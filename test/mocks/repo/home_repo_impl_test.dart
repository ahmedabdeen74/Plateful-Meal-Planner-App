import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:meal_planner/core/utility/errors/failures.dart';

import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/data/repo/home_repo_impl.dart';

import 'mock_data_sources.dart';
void main() {
  late MockHomeRemoteDataSource mockRemote;
  late MockHomeLocalDataSource mockLocal;
  late HomeRepoImpl repo;

  setUp(() {
    mockRemote = MockHomeRemoteDataSource();
    mockLocal = MockHomeLocalDataSource();
    repo = HomeRepoImpl(
      homeRemoteDataSource: mockRemote,
      homeLocalDataSource: mockLocal,
    );
  });

  group("HomeRepoImpl - fetchMeals()", () {
    test("should return list of meals when remote call succeeds", () async {
      // Arrange
      final meal = Meal(strMeal: "Chicken");
      final mealsList = [meal];

      when(() => mockRemote.fetchMeals(count: any(named: "count")))
          .thenAnswer((_) async => Right(mealsList));

      // Act
      final result = await repo.fetchMeals(count: 5);

      // Assert
      expect(result, Right(mealsList));
      verify(() => mockRemote.fetchMeals(count: 5)).called(1);
    });

    test("should return Failure when remote call fails", () async {
      // Arrange
      final failure = ServerFailure(errMessage: "Server error");

      when(() => mockRemote.fetchMeals(count: any(named: "count")))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await repo.fetchMeals(count: 5);

      // Assert
      expect(result, Left(failure));
      verify(() => mockRemote.fetchMeals(count: 5)).called(1);
    });
  });

  group("HomeRepoImpl - fetchMealDetails()", () {
    test("should return meal details on success", () async {
      // Arrange
      final meal = Meal(strMeal: "Pasta");

      when(() => mockRemote.fetchMealDetails(any()))
          .thenAnswer((_) async => Right(meal));

      // Act
      final result = await repo.fetchMealDetails("10");

      // Assert
      expect(result, Right(meal));
      verify(() => mockRemote.fetchMealDetails("10")).called(1);
    });

    test("should return Failure when remote fails", () async {
      // Arrange
      final failure = ServerFailure(errMessage: "API error");

      when(() => mockRemote.fetchMealDetails(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await repo.fetchMealDetails("22");

      // Assert
      expect(result, Left(failure));
      verify(() => mockRemote.fetchMealDetails("22")).called(1);
    });
  });
}
