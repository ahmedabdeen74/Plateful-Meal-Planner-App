part of 'fetch_filter_category_cubit.dart';

sealed class FetchFilterCategoryState extends Equatable {
  const FetchFilterCategoryState();

  @override
  List<Object> get props => [];
}

final class FetchFilterCategoryInitial extends FetchFilterCategoryState {}

final class FetchFilterCategoryLoading extends FetchFilterCategoryState {}

final class FetchFilterCategorySuccess extends FetchFilterCategoryState {
  final List<Meal> filterCategory;

  const FetchFilterCategorySuccess({required this.filterCategory});
}

final class FetchFilterCategoryFailure extends FetchFilterCategoryState {
  final String errMessage;

  const FetchFilterCategoryFailure({required this.errMessage});
}
