import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/core/network/api_service.dart';
import 'package:meal_planner/core/utility/di/service_locator.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo_impl.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_area/fetch_area_notifie.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_area/fetch_area_state.dart';

final exploreRepoProvider = Provider<ExploreRepo>((ref) {
  return ExploreRepoImpl(apiService: getIt<ApiService>());
});
final fetchAreaProvider =
    StateNotifierProvider<FetchAreaNotifier, FetchAreaState>((ref) {
  final repo = ref.watch(exploreRepoProvider);
  return FetchAreaNotifier(repo);
});

