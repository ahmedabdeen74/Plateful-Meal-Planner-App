import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_planner/core/utility/use_case/use_case.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/domain/use_case/fetch_meal_details.dart';

part 'fetch_meal_details_state.dart';
class FetchMealDetailsCubit extends Cubit<FetchMealDetailsState> {
  final UseCase useCase;

  FetchMealDetailsCubit(this.useCase)
    : super(const FetchMealDetailsState(status: FetchMealDetailsStatus.initial));

  fetchMealDetails({required String id}) async {
    emit(state.copyWith(status: FetchMealDetailsStatus.loading));

    final result = await useCase.call(id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FetchMealDetailsStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (meal) => emit(
        state.copyWith(
          status: FetchMealDetailsStatus.loaded,
          errorMessage: null,
          meal: meal,
        ),
      ),
    );
    
  }
  
  
  
}
/*
class FetchMealDetailsCubit extends Cubit<FetchMealDetailsState> {
  FetchMealDetailsCubit(this.useCase) : super(FetchMealDetailsInitial());
  final FetchMealDetailsUseCase useCase;
  fetchMealDetails({required String id}) async {
    emit(FetchMealDetailsLoading());
    final result = await useCase.call(id);
    result.fold(
      (failure) => emit(FetchMealDetailsFailure(failure.errMessage)),
      (meal) => emit(FetchMealDetailsSuccess(meal)),
    );
  }
}
*/
