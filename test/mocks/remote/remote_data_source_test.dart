import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:meal_planner/core/network/api_service.dart';
import 'package:meal_planner/core/network/app_endpoints.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/home/data/data_sources/remote/home_remote_data_source.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal_model.dart';

/// ---------------------- MOCK ----------------------
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApi;
  late HomeRemoteDataSourceImpl remote;

  setUp(() {
    mockApi = MockApiService();
    remote = HomeRemoteDataSourceImpl(apiService: mockApi);
  });
  /// ---------------------- FAKE DATA ----------------------
  final fakeJson = {
    "meals": [
      {"strMeal": "Pizza"}
    ]
  };

  /// ---------------------- TESTS ----------------------

  group("fetchMealDetails", () {
    test("should return Meal when API returns success", () async {
      // Arrange
      when(() => mockApi.requestAPI(
            url: AppEndpoints.mealDetails("5"),
            type: RequestType.get,
            headers: any(named: "headers"),
          )).thenAnswer((_) async => fakeJson);

      // Act
      final result = await remote.fetchMealDetails("5");

      // Assert
      expect(result.isRight(), true);
      expect(result.getOrElse(() => Meal(strMeal: "")), isA<Meal>());
      verify(() => mockApi.requestAPI(
            url: AppEndpoints.mealDetails("5"),
            type: RequestType.get,
            headers: {},
          )).called(1);
    });

    test("should return Failure when API throws exception", () async {
      // Arrange
      when(() => mockApi.requestAPI(
            url: AppEndpoints.mealDetails("5"),
            type: RequestType.get,
            headers: any(named: "headers"),
          )).thenThrow(DioException(requestOptions: RequestOptions(path: "")));

      // Act
      final result = await remote.fetchMealDetails("5");

      // Assert
      expect(result.isLeft(), true);
    });
  });

  group("fetchMeals", () {
    test("should return List<Meal> when all API calls succeed", () async {
      // Arrange
      when(() => mockApi.requestAPI(
            url: AppEndpoints.randomMeal,
            type: RequestType.get,
            headers: any(named: "headers"),
          )).thenAnswer((_) async => fakeJson);

      // Act
      final result = await remote.fetchMeals(count: 3);

      // Assert
      expect(result.isRight(), true);
      final meals = result.getOrElse(() => []);
      expect(meals.length, 3);
      expect(meals.first.strMeal, "Pizza");

      verify(() => mockApi.requestAPI(
            url: AppEndpoints.randomMeal,
            type: RequestType.get,
            headers: {},
          )).called(3);
    });

    test("should return Failure when ANY API call throws exception", () async {
      // Arrange
      when(() => mockApi.requestAPI(
            url: AppEndpoints.randomMeal,
            type: RequestType.get,
            headers: any(named: "headers"),
          )).thenThrow(Exception("API error"));

      // Act
      final result = await remote.fetchMeals(count: 2);

      // Assert
      expect(result.isLeft(), true);

      verify(() => mockApi.requestAPI(
            url: AppEndpoints.randomMeal,
            type: RequestType.get,
            headers: {},
          )).called(1);
    });
  });
}
