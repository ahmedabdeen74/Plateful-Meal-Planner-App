import 'package:dartz/dartz.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Meal>>> fetchMeals({required int count});
  Future<Either<Failure, Meal>> fetchMealDetails(String mealId);

  //Future<void> saveFavoriteMeal(String mealId);
  //Future<List<String>> fetchFavoriteMeals();
  // Future<void> removeFavoriteMeal(String mealId);
}

