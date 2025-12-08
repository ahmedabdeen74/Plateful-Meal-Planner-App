import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/domain/repo/home_repo.dart';
import 'package:meal_planner/features/home/domain/use_case/fetch_meals_use_case.dart';

/// --------- Mock ---------
class MockHomeRepo extends Mock implements HomeRepo {}

void main() {
  late MockHomeRepo mockRepo;
  late FetchMealsUseCase useCase;

  setUp(() {
    mockRepo = MockHomeRepo();
    useCase = FetchMealsUseCase(homeRepo: mockRepo);
  });

  group("FetchMealsUseCase Tests", () {
    test("should return meals when repo returns Right", () async {
      // Arrange
      final meals = [Meal(strMeal: "Pizza")];

      when(() => mockRepo.fetchMeals(count: 5))
          .thenAnswer((_) async => Right(meals));

      // Act
      final result = await useCase(5);

      // Assert
      expect(result, Right(meals));
      verify(() => mockRepo.fetchMeals(count: 5)).called(1);
    });

    test("should return Failure when repo returns Left", () async {
      // Arrange
      final failure = ServerFailure(errMessage: "Network error");

      when(() => mockRepo.fetchMeals(count: 5))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(5);

      // Assert
      expect(result, Left(failure));
      verify(() => mockRepo.fetchMeals(count: 5)).called(1);
    });

    test("should use default count when null is passed", () async {
      // Arrange
      final meals = [Meal(strMeal: "Burger")];

      when(() => mockRepo.fetchMeals(count: 8))
          .thenAnswer((_) async => Right(meals));

      // Act
      final result = await useCase();

      // Assert
      expect(result, Right(meals));
      verify(() => mockRepo.fetchMeals(count: 8)).called(1);
    });
  });
}
