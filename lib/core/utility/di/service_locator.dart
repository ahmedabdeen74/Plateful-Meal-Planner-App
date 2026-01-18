import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_planner/core/network/api_service.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo_impl.dart';
import 'package:meal_planner/features/home/inject_home.dart';
import 'package:meal_planner/features/search/data/repo/search_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));


  injectHome();


  getIt.registerLazySingleton<SearchRepoImpl>(
      () => SearchRepoImpl(apiService: getIt<ApiService>()));

  getIt.registerLazySingleton<ExploreRepoImpl>(
      () => ExploreRepoImpl(apiService: getIt<ApiService>()));
      
}

/*
final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio())); // for diffrent repo
  // clean architecture
  // UseCases
  
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        apiService: getIt.get<ApiService>(),
       // localDataSource: HomeLocalDataSourceImpl(),
      ),
    ),
  );
  getIt.registerSingleton<FetchMealsUseCase>(
    FetchMealsUseCase(homeRepo: getIt<HomeRepoImpl>()),
  );

  getIt.registerSingleton<FetchMealDetailsUseCase>(
    FetchMealDetailsUseCase(homeRepo: getIt<HomeRepoImpl>()),
  );
  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ExploreRepoImpl>(
    ExploreRepoImpl(apiService: getIt.get<ApiService>()),
  );
  // getIt.get<ApiService>();
}
*/