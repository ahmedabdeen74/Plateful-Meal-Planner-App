import 'package:bloc/bloc.dart';
import 'package:meal_planner/core/utility/use_case/use_case.dart';
import 'fetch_meals_event.dart';
import 'fetch_meals_state.dart';

class FetchMealsBloc extends Bloc<FetchMealsEvent, FetchMealsState> {
  final UseCase fetchMealsUseCase;

  FetchMealsBloc(this.fetchMealsUseCase)
    : super(const FetchMealsState(status: FetchMealsStatus.initial)) {
    on<FetchMealsRequested>(_onFetchMealsRequested);
  }

  Future<void> _onFetchMealsRequested(
    FetchMealsRequested event,
    Emitter<FetchMealsState> emit,
  ) async {
    emit(state.copyWith(status: FetchMealsStatus.loading));

    final result = await fetchMealsUseCase.call(event.count);

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
