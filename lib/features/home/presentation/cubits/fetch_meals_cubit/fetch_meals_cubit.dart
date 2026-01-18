import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_planner/core/utility/use_case/use_case.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';

part 'fetch_meals_state.dart';

class FetchMealsCubit extends Cubit<FetchMealsState> {
  final UseCase fetchMealsUseCase;

  FetchMealsCubit(this.fetchMealsUseCase)
    : super(const FetchMealsState(status: FetchMealsStatus.initial));

  Future<void> fetchMeals({required int count}) async {
    emit(state.copyWith(status: FetchMealsStatus.loading));

    final result = await fetchMealsUseCase.call(count);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FetchMealsStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (meals) => emit(
        state.copyWith(
          status: FetchMealsStatus.loaded,
          errorMessage: null,
          meals: meals,
        ),
      ),
    );
  }

  
}

/*
class FetchMealsCubit extends Cubit<FetchMealsState> {
  FetchMealsCubit(this.useCase) : super(FetchMealsInitial());
  final FetchMealsUseCase useCase;
  fetchMeals({required int count}) async {
    emit(FetchMealsLoading());
    final result = await useCase.call(count);
    result.fold(
      (failure) => emit(FetchMealsFailure(failure.errMessage)),
      (meals) => emit(FetchMealsSuccess(meals)),
    );
  }
 /* void fetchMealsFromCache() {
    final localMeals = useCase.homeRepo.fetchMealsFromCache();
    if (localMeals.isNotEmpty) {
      emit(FetchMealsSuccess(localMeals));
    }
  }*/
  
}
*/
