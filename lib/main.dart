import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/constants.dart';

import 'package:meal_planner/core/utility/di/service_locator.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/features/calendar/data/local/calendar/calendar_cubit.dart';
import 'package:meal_planner/features/calendar/data/models/calendar_meal.dart';
import 'package:meal_planner/features/favourite/data/local/Favourite/add_meal_cubit.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/bloc/fetch_meals/fetch_meals_bloc.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';
import 'package:meal_planner/firebase_options.dart';
import 'package:meal_planner/simple_bloc_observer.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(CalendarMealAdapter());
  await Hive.openBox<Meal>(kMealBox);
  await Hive.openBox<Meal>(kCacheMealDetails);
  await Hive.openBox<Meal>(kCacheMeal);
  await Hive.openBox<CalendarMeal>(kMealBoxCalendar);
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MealPlanner()));
}

class MealPlanner extends StatelessWidget {
  const MealPlanner({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FetchMealsBloc>()),
      //  BlocProvider(create: (_) => getIt<FetchMealsCubit>()),
        BlocProvider(create: (_) => getIt<FetchMealDetailsCubit>()),
        BlocProvider(create: (_) => AddMealCubit()),
        BlocProvider(create: (_) => CalendarCubit()),
      ],
      child: MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
