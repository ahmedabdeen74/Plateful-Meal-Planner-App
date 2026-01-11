import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_area/fetch_area_state.dart';

class FetchAreaNotifier extends StateNotifier<FetchAreaState> {
  FetchAreaNotifier(this.exploreRepo) : super(FetchAreaInitial());

  final ExploreRepo exploreRepo;

  Future<void> fetchArea() async {
    state = FetchAreaLoading();

    final result = await exploreRepo.fetchArea();

    result.fold(
      (failure) => state = FetchAreaFailure(errMessage: failure.errMessage),
      (meals) => state = FetchAreaSuccess(areas: meals),
    );
  }
}
