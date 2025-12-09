import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/core/utility/errors/failures.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meals_cubit/fetch_meals_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/core/utility/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class FakeFailure implements Failure {
  final String message;
  FakeFailure(this.message);
  
  @override
  List<Object?> get props => [message];
  
  @override
  String get errMessage => message;
}

class MockFetchMealsUseCase extends Mock implements UseCase {}

void main() {
  late MockFetchMealsUseCase mockUseCase;
  late FetchMealsCubit cubit;

  const count = 5;

  final fakeMeals = [
     Meal(strMeal: "Pizza"),
     Meal(strMeal: "Burger"),
  ];

  setUp(() {
    mockUseCase = MockFetchMealsUseCase();
    cubit = FetchMealsCubit(mockUseCase);
  });

  group('FetchMealsCubit Tests', () {
    test('initial state should be initial', () {
      expect(
        cubit.state.status,
        FetchMealsStatus.initial,
      );
    });

    blocTest<FetchMealsCubit, FetchMealsState>(
      'emits [loading, loaded] when API success',
      build: () {
        when(() => mockUseCase.call(count))
            .thenAnswer((_) async => Right(fakeMeals));

        return cubit;
      },
      act: (cubit) => cubit.fetchMeals(count: count),
      expect: () => [
        const FetchMealsState(status: FetchMealsStatus.loading),
        FetchMealsState(
          status: FetchMealsStatus.loaded,
          meals: fakeMeals,
          errorMessage: null,
        ),
      ],
    );

    blocTest<FetchMealsCubit, FetchMealsState>(
      'emits [loading, error] when API fails',
      build: () {
        when(() => mockUseCase.call(count))
            .thenAnswer((_) async => Left(FakeFailure("Network Error")));

        return cubit;
      },
      act: (cubit) => cubit.fetchMeals(count: count),
      expect: () => [
        const FetchMealsState(status: FetchMealsStatus.loading),
        const FetchMealsState(
          status: FetchMealsStatus.error,
          errorMessage: "Network Error",
        ),
      ],
    );
  });
}
