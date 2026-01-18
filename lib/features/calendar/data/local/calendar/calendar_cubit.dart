import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/features/calendar/data/local/calendar/calendar_state.dart' show CalendarState, CalendarInitial, CalendarLoading, CalendarFailure, CalendarLoaded, CalendarMealAdded, CalendarMealRemoved;
import 'package:meal_planner/features/calendar/data/models/calendar_meal.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';


class CalendarCubit extends Cubit<CalendarState> {
  //static const String kCalendarBox = 'calendar_meals';
  List<CalendarMeal> _calendarMeals = [];

  CalendarCubit() : super(CalendarInitial()) {
    _loadCalendarMeals();
  }

  void _loadCalendarMeals() {
    try {
      var calendarBox = Hive.box<CalendarMeal>(kMealBoxCalendar);
      _calendarMeals = calendarBox.values.toList();
      
      // ترتيب الوجبات حسب التاريخ (الأقرب أولاً)
      _calendarMeals.sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
      
      emit(CalendarLoaded(meals: List.from(_calendarMeals)));
    } catch (e) {
      print("❌ Error loading calendar meals: $e");
      emit(CalendarFailure(errorMessage: "Error loading meals: ${e.toString()}"));
    }
  }

  // إضافة وجبة إلى التقويم
  Future<void> addMealToCalendar(Meal meal, DateTime selectedDate) async {
    try {
      emit(CalendarLoading());
      
      final calendarBox = Hive.box<CalendarMeal>(kMealBoxCalendar);
      
      // إنشاء ID فريد للوجبة مع التاريخ
      final id = '${meal.idMeal}_${selectedDate.millisecondsSinceEpoch}';
      
      // التحقق من عدم وجود نفس الوجبة في نفس التاريخ
      final existingMeal = _calendarMeals.firstWhere(
        (calendarMeal) => 
          calendarMeal.meal.idMeal == meal.idMeal && 
          _isSameDate(calendarMeal.scheduledDate, selectedDate),
        orElse: () => CalendarMeal(meal: meal, scheduledDate: DateTime.now(), id: ''),
      );
      
      if (existingMeal.id.isNotEmpty) {
        emit(CalendarFailure(errorMessage: "This meal is already scheduled for this date"));
        return;
      }
      
      final calendarMeal = CalendarMeal(
        meal: meal,
        scheduledDate: selectedDate,
        id: id,
      );
      
      await calendarBox.add(calendarMeal);
      _calendarMeals.add(calendarMeal);
      
      // إعادة ترتيب القائمة
      _calendarMeals.sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
      
      emit(CalendarMealAdded(meals: List.from(_calendarMeals)));
    } catch (e) {
      print('Error adding meal to calendar: $e');
      emit(CalendarFailure(errorMessage: e.toString()));
    }
  }

  // حذف وجبة من التقويم
  Future<void> removeMealFromCalendar(CalendarMeal calendarMeal) async {
    try {
      emit(CalendarLoading());
      
      final calendarBox = Hive.box<CalendarMeal>(kMealBoxCalendar);
      
      // البحث عن الوجبة وحذفها
      final keys = calendarBox.keys.where((key) {
        final mealInBox = calendarBox.get(key);
        return mealInBox?.id == calendarMeal.id;
      }).toList();
      
      for (final key in keys) {
        await calendarBox.delete(key);
      }
      
      _calendarMeals.removeWhere((meal) => meal.id == calendarMeal.id);
      
      emit(CalendarMealRemoved(meals: List.from(_calendarMeals)));
    } catch (e) {
      emit(CalendarFailure(errorMessage: "Error removing meal: ${e.toString()}"));
    }
  }

  // الحصول على الوجبات المجدولة
  List<CalendarMeal> get calendarMeals => List.from(_calendarMeals);

  // الحصول على الوجبات مجمعة حسب التاريخ
  Map<DateTime, List<CalendarMeal>> getMealsGroupedByDate() {
    final Map<DateTime, List<CalendarMeal>> groupedMeals = {};
    
    for (final calendarMeal in _calendarMeals) {
      final dateKey = DateTime(
        calendarMeal.scheduledDate.year,
        calendarMeal.scheduledDate.month,
        calendarMeal.scheduledDate.day,
      );
      
      if (!groupedMeals.containsKey(dateKey)) {
        groupedMeals[dateKey] = [];
      }
      groupedMeals[dateKey]!.add(calendarMeal);
    }
    
    return groupedMeals;
  }

  // التحقق من تطابق التواريخ
  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  // تحديث البيانات
  void refreshCalendar() {
    _loadCalendarMeals();
  }

  // إعادة تعيين الحالة
  void resetState() {
    emit(CalendarInitial());
  }
}