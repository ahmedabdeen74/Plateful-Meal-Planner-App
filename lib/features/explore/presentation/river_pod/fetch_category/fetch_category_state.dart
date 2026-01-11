// States
import 'package:meal_planner/features/explore/data/models/category/meal.dart';

abstract class FetchCategoryState {
  const FetchCategoryState();
}

class FetchCategoryInitial extends FetchCategoryState {}

class FetchCategoryLoading extends FetchCategoryState {}

class FetchCategorySuccess extends FetchCategoryState {
  final List<CategoryMeal> categories;

  const FetchCategorySuccess(this.categories);
}

class FetchCategoryFailure extends FetchCategoryState {
  final String message;

  const FetchCategoryFailure(this.message);
}