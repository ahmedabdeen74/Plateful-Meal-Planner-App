import 'package:dartz/dartz.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/home/data/data_sources/local/home_local_data_source.dart';
import 'package:meal_planner/features/home/data/data_sources/remote/home_remote_Data_source.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, Meal>> fetchMealDetails(String mealId) async {
    /*  final localMeal = homeLocalDataSource.fetchMealDetails(mealId);
    if (localMeal != null) {
       homeRemoteDataSource.fetchMealDetails(mealId);
      return right(localMeal);
    }*/
    return await homeRemoteDataSource.fetchMealDetails(mealId);
  }

  @override
  Future<Either<Failure, List<Meal>>> fetchMeals({required int count}) async {
    /*final localMeals = homeLocalDataSource.fetchMeals();
    if (localMeals.isNotEmpty) {
     homeRemoteDataSource.fetchMeals(count: count); 
      return right(localMeals);
    }*/
    return await homeRemoteDataSource.fetchMeals(count: count);
  }

  
}


/*
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, Meal>> fetchMealDetails(String mealId) async {
    final result = await homeRemoteDataSource.fetchMealDetails(mealId);
    return result; // لا حاجة لاستخدام fold هنا
  }

  @override
  Future<Either<Failure, List<Meal>>> fetchMeals({required int count}) async {
    var meal = await homeLocalDataSource.fetchMeals();
    if (meal != null && meal.isNotEmpty) {
      return right(meal);
    }
    var meals = await homeRemoteDataSource.fetchMeals(count: count);
    return right(meals);
  }

  /*  @override
  Future<Either<Failure, List<Meal>>> fetchMeals({required int count}) async {
    var meal = await homeLocalDataSource.fetchMeals();
    if (meal.isNotEmpty) {
      return right(meal);
    }
    var meals = await homeRemoteDataSource.fetchMeals(count: count);
    return right(meals);
  }*/
}

/*class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Meal>>> getMeals() async {
    try {
      final meals = await remoteDataSource.fetchMeals();
      return Right(meals);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Meal>>> getCachedMeals() async {
    try {
      final meals = await localDataSource.getCachedMeals();
      return Right(meals);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

}
*/

*/