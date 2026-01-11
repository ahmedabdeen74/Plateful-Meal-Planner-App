import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';

part 'fetch_filter_area_state.dart';

class FetchFilterAreaCubit extends Cubit<FetchFilterAreaState> {
  FetchFilterAreaCubit(this.exploreRepo) : super(FetchFilterAreaInitial());
  final ExploreRepo exploreRepo;
  fetchFilterArea({required String area}) async{
    emit(FetchFilterAreaLoading());
   var result = await  exploreRepo.fetchFilterArea(area: area);
   result.fold((failure) => emit(FetchFilterAreaFailure(errMessage: failure.errMessage)), (meals)=> emit(FetchFilterAreaSuccess(filterArea: meals)));
  }
}
