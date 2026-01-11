import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_planner/features/explore/data/models/area/meal.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';

part 'fetch_area_state.dart';

class FetchAreaCubit extends Cubit<FetchAreaState> {
  FetchAreaCubit(this.exploreRepo) : super(FetchAreaInitial());
  final ExploreRepo exploreRepo;
  fetchArea()async {
    emit(FetchAreaLoading());
    final result =await exploreRepo.fetchArea();
    result.fold(
      (failure) => emit(FetchAreaFailure(errMessage: failure.errMessage)),
      (meals) => emit(FetchAreaSuccess(areas: meals)),
    );
  }
}
