import 'package:dartz/dartz.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/explore/data/models/area/meal.dart'
    show Meal, AreaMeal;
import 'package:meal_planner/features/explore/data/models/category/meal.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';

abstract class ExploreRepo {
  Future<Either<Failure, List<AreaMeal>>> fetchArea();
  Future<Either<Failure, List<CategoryMeal>>> fetchCategory();
  Future<Either<Failure, List<Meal>>> fetchFilterArea({required String area});
  Future<Either<Failure, List<Meal>>> fetchFilterCategory({required String category});
}
