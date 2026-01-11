import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart' show Meal;

part 'fetch_filter_category_state.dart';

class FetchFilterCategoryCubit extends Cubit<FetchFilterCategoryState> {
FetchFilterCategoryCubit(this.exploreRepo) : super(FetchFilterCategoryInitial());
  final ExploreRepo exploreRepo;
  fetchFilterCategory({required String category}) async{
    emit(FetchFilterCategoryLoading());
   var result = await  exploreRepo.fetchFilterCategory(category: category);
   result.fold((failure) => emit(FetchFilterCategoryFailure(errMessage: failure.errMessage)), (meals)=> emit(FetchFilterCategorySuccess(filterCategory: meals)));
  }
}