import 'package:get_it/get_it.dart';
import 'package:meal_planner/core/network/api_service.dart';
import 'package:meal_planner/core/utility/use_case/use_case.dart';
import 'package:meal_planner/features/home/data/data_sources/local/home_local_data_source.dart';
import 'package:meal_planner/features/home/data/data_sources/remote/home_remote_Data_source.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/data/repo/home_repo_impl.dart';
import 'package:meal_planner/features/home/domain/repo/home_repo.dart';
import 'package:meal_planner/features/home/domain/use_case/fetch_meal_details.dart';
import 'package:meal_planner/features/home/domain/use_case/fetch_meals_use_case.dart';
import 'package:meal_planner/features/home/presentation/bloc/fetch_meals/fetch_meals_bloc.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meals_cubit/fetch_meals_cubit.dart';

final getIt = GetIt.instance;

void injectHome() {
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeLocalDataSource: getIt(),
      homeRemoteDataSource: getIt(),
    ),
  );

  // Register abstract use case type
  getIt.registerLazySingleton<UseCase<List<Meal>, int>>(
    () => FetchMealsUseCase(homeRepo: getIt()),
  );

  // Register details use case
  getIt.registerLazySingleton<UseCase<Meal, String>>(
    () => FetchMealDetailsUseCase(homeRepo: getIt()),
  );

  // Cubits
  getIt.registerFactory(
    () => FetchMealsCubit(getIt<UseCase<List<Meal>, int>>()),
  );
  // bloc
  getIt.registerFactory(
    () => FetchMealsBloc(getIt<UseCase<List<Meal>, int>>()),
  );

  getIt.registerFactory(
    () => FetchMealDetailsCubit(getIt<UseCase<Meal, String>>()),
  );
}

/*
final getIt = GetIt.instance;
void injectHome() {
  // Data Sources
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeLocalDataSource: getIt(),
      homeRemoteDataSource: getIt(),
    ),
  );
  /* getIt.registerLazySingleton<HomeRepoImpl>(
    () => HomeRepoImpl(
      homeLocalDataSource: getIt(),
      homeRemoteDataSource: getIt(),
    ),
  );*/

  // UseCases
  getIt.registerLazySingleton<FetchMealsUseCase>(
    () => FetchMealsUseCase(homeRepo: getIt()),
  );

  getIt.registerLazySingleton<FetchMealDetailsUseCase>(
    () => FetchMealDetailsUseCase(homeRepo: getIt()),
  );

  // Cubits
  getIt.registerFactory<FetchMealsCubit>(() => FetchMealsCubit(getIt()));

  getIt.registerFactory<FetchMealDetailsCubit>(
    () => FetchMealDetailsCubit(getIt()),
  );
}
*/
