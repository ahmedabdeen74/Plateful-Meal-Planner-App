import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/app_router.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';
import 'package:meal_planner/features/calendar/data/local/calendar/calendar_cubit.dart';
import 'package:meal_planner/features/calendar/data/local/calendar/calendar_state.dart' show CalendarFailure, CalendarMealAdded, CalendarState, CalendarLoading;
import 'package:meal_planner/features/favourite/data/local/Favourite/add_meal_cubit.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';

import '../../../../../core/utility/routers/app_router.dart';

class MealDetailsAppBar extends StatelessWidget {
  const MealDetailsAppBar({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listener للـ Favorite Cubit
        BlocListener<AddMealCubit, AddMealState>(
          listener: (context, state) {
            if (state is AddMealSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showSuccessDialog(context, "✅ The meal has been added to favorites successfully");
              });
            } else if (state is RemoveMealSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showSuccessDialog(context, "✅ The meal has been removed from favorites successfully");
              });
            } else if (state is AddMealFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showErrorDialog(context, state.errMessage);
              });
            }
          },
        ),
        // Listener للـ Calendar Cubit
        BlocListener<CalendarCubit, CalendarState>(
          listener: (context, state) {
            if (state is CalendarMealAdded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showSuccessDialog(context, "✅ The meal has been added to calendar successfully");
              });
            } else if (state is CalendarFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showErrorDialog(context, state.errorMessage);
              });
            }
          },
        ),
      ],
      child: BlocBuilder<AddMealCubit, AddMealState>(
        builder: (context, favoriteState) {
          return BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, calendarState) {
              final isFavorite = BlocProvider.of<AddMealCubit>(context).isMealInFavorites(meal);
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(AssetsData.backButton),
                  ),
                  const Text("Meal to Prepare", style: Styles.textStyleMedium18),
                  PopupMenuButton<int>(
                    icon: Image.asset(AssetsData.dot3),
                    offset: const Offset(0, 45),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            // Add To Calendar Button
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop(); // إغلاق القائمة
                                final user = await AuthService().getCurrentUser();
                                if (user == null) {
                                  _showSignInDialog(context);
                                } else {
                                  await _showDatePicker(context);
                                }
                              },
                              child: Row(
                                children: [
                                  calendarState is CalendarLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.calendar_today, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    calendarState is CalendarLoading 
                                        ? "Adding to Calendar..." 
                                        : "Add To Calendar",
                                    style: Styles.textStyleRegular18,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Favorite Button
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop(); // إغلاق القائمة
                                final user = await AuthService().getCurrentUser();
                                if (user == null) {
                                  _showSignInDialog(context);
                                } else {
                                  BlocProvider.of<AddMealCubit>(context).toggleFavorite(meal);
                                }
                              },
                              child: Row(
                                children: [
                                  favoriteState is AddMealLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : Icon(
                                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                                          size: 24,
                                          color: isFavorite ? Colors.red : null,
                                        ),
                                  const SizedBox(width: 12),
                                  Text(
                                    favoriteState is AddMealLoading
                                        ? "Processing..."
                                        : isFavorite
                                            ? "Remove from Favorites"
                                            : "Add to Favorites",
                                    style: Styles.textStyleRegular18,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Share Button
                            GestureDetector(
                              onTap: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.share, size: 24),
                                  SizedBox(width: 12),
                                  Text("Share", style: Styles.textStyleRegular18),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // عرض Date Picker
  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Select meal date',
      cancelText: 'Cancel',
      confirmText: 'Add to Calendar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange,
              brightness: Brightness.light,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      // إضافة الوجبة إلى التقويم
      if (context.mounted) {
        BlocProvider.of<CalendarCubit>(context).addMealToCalendar(meal, selectedDate);
      }
    }
  }

  // عرض رسالة نجاح
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // عرض رسالة خطأ
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // عرض رسالة تسجيل الدخول
  void _showSignInDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Sign In Required"),
        content: const Text("You need to sign in to access this feature."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              GoRouter.of(context).push(AppRouter.kLoginView);
            },
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}