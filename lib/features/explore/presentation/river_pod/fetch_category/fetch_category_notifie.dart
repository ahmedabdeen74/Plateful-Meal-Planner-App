import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/explore_repo_provider.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_category/fetch_category_state.dart';




// Notifier
class FetchCategoryNotifier extends StateNotifier<FetchCategoryState> {
  final ExploreRepo repo;

  FetchCategoryNotifier(this.repo) : super(FetchCategoryInitial());

  Future<void> fetchCategory() async {
    state = FetchCategoryLoading();

    final result = await repo.fetchCategory();

    result.fold(
      (failure) => state = FetchCategoryFailure(failure.errMessage),
      (categories) => state = FetchCategorySuccess(categories),
    );
  }
}

// Provider
final fetchCategoryProvider =
    StateNotifierProvider<FetchCategoryNotifier, FetchCategoryState>(
  (ref) => FetchCategoryNotifier(ref.read(exploreRepoProvider)),
);
