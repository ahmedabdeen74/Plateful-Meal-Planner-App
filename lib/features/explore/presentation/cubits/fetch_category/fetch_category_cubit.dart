import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_planner/features/explore/data/models/area/meal.dart';
import 'package:meal_planner/features/explore/data/models/category/meal.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';

part 'fetch_category_state.dart';

class FetchCategoryCubit extends Cubit<FetchCategoryState> {
  FetchCategoryCubit(this.exploreRepo) : super(FetchCategoryInitial());
  final ExploreRepo exploreRepo;
  fetchCategory()async {
    emit(FetchCategoryLoading());
    final result =await exploreRepo.fetchCategory();
    result.fold(
      (failure) => emit(FetchCategoryFailure(errMessage: failure.errMessage)),
      (meals) => emit(FetchCategorySuccess(categories: meals)),
    );
  }
}

