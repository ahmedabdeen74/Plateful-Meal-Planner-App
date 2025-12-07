import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/core/utility/app_router.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
 void saveMeals(List<Meal> meals) {
    var box = Hive.box<Meal>(kCacheMeal);
    box.addAll(meals);
  }
  void saveMealDetails(Meal meal) {
    var box = Hive.box<Meal>(kCacheMealDetails);
    box.add(meal);
  }

Future<void> saveMealToHistory(String mealName) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'recentSearch';

  List<String> meals = prefs.getStringList(key) ?? [];

  meals.removeWhere(
    (item) => item.trim().toLowerCase() == mealName.trim().toLowerCase(),
  );


  meals.insert(0, mealName.trim());

  if (meals.length > 10) {
    meals = meals.sublist(0, 10);
  }

  // نخزنها
  await prefs.setStringList(key, meals);
}

/// Shows a success dialog with a given message.
///
/// [context]: The BuildContext used to show the dialog.
/// [message]: The success message to display.
void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: kAlertColor,
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

/// Shows an error dialog with a given message.
///
/// [context]: The BuildContext used to show the dialog.
/// [message]: The error message to display.
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: kAlertColor,
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

void showProfileDialog(
  BuildContext context,
  String displayName,
  String? email,
) {
  showDialog(
    //  barrierColor: Colors.amberAccent,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: kAlertColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // User image
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AssetsData.user), // Placeholder image
              // Future: Replace with Firebase Storage image
            ),
          ),
          SizedBox(height: 16),
          // User email
          Text(
            email ?? 'Unavailable',
            style: Styles.textStyleBold14.copyWith(color: Colors.black87),
          ),
          SizedBox(height: 8),
          // User location (placeholder)
          Text(
            'Cairo, Egypt', // Placeholder for location
            style: Styles.textStyleLight14.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 16),
          // First container
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kFavouriteView);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your Favourite ", style: Styles.textStyleSemibold21),
                  const SizedBox(width: 16),
                  const Icon(Icons.favorite, color: Colors.red),
                ],
              ),

              // Future: Add functionality here
            ),
          ),
          SizedBox(height: 8),
          // Second container
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kCalendarView);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your Calendar ", style: Styles.textStyleSemibold21),
                  const SizedBox(width: 16),
                  const Icon(Icons.calendar_month),
                ],
              ),
              // Future: Add functionality here
            ),
          ),
          SizedBox(height: 16),
          // Center text
          /* Text(
              'Profile Settings',
              style: Styles.textStyleBold24.copyWith(color: Colors.black87),
            ),*/
          SizedBox(height: 16),
          // Sign out button
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: kAlertColor,
                  title: Text('Confirm Sign Out'),
                  content: Text('Are you sure you want to sign out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await AuthService().signOut();
                        Navigator.pop(context); // Close confirmation dialog
                        Navigator.pop(context); // Close profile dialog
                        GoRouter.of(
                          context,
                        ).pushReplacement(AppRouter.kAuthView);
                      },
                      child: Text('Sign Out'),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Sign Out',
              style: Styles.textStyleBold14.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    ),
  );
}


