part of 'fetch_category_cubit.dart';

sealed class FetchCategoryState extends Equatable {
  const FetchCategoryState();

  @override
  List<Object> get props => [];
}

final class FetchCategoryInitial extends FetchCategoryState {}
final class FetchCategoryLoading extends FetchCategoryState {}

final class FetchCategorySuccess extends FetchCategoryState {
  final List<CategoryMeal> categories;

  const FetchCategorySuccess({required this.categories});
}

final class FetchCategoryFailure extends FetchCategoryState {
  final String errMessage;

  const FetchCategoryFailure({required this.errMessage});
}

