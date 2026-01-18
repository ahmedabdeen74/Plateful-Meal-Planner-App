import 'package:dartz/dartz.dart';
import 'package:meal_planner/core/network/api_service.dart';
import 'package:meal_planner/core/network/app_endpoints.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, Meal>> fetchMealDetails(String id);
  Future<Either<Failure, List<Meal>>> fetchMeals({required int count});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, Meal>> fetchMealDetails(String id) async {
    try {
      final data = await apiService.requestAPI(
        url: AppEndpoints.mealDetails(id),
        type: RequestType.get,
        headers: {},
      );
      final Meal meal = MealModel.fromJson(data).meals!.first;
      return right(meal);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Meal>>> fetchMeals({required int count}) async {
    try {
      final futures = List.generate(
        count,
        (_) => apiService.requestAPI(
          url: AppEndpoints.randomMeal,
          type: RequestType.get,
          headers: {},
        ),
      );

      final responses = await Future.wait(futures);
      final meals = responses
          .map((data) => MealModel.fromJson(data).meals?.first)
          .whereType<Meal>()
          .toList();

      return right(meals);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
