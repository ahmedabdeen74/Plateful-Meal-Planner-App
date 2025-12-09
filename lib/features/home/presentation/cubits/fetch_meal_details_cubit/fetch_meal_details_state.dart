part of 'fetch_meal_details_cubit.dart';
enum FetchMealDetailsStatus { initial, loading, loaded, error }

class FetchMealDetailsState extends Equatable {
  final FetchMealDetailsStatus status;
  final String? errorMessage;
  final Meal? meal;

  const FetchMealDetailsState({
    required this.status,
    this.errorMessage,
    this.meal,
  });

  FetchMealDetailsState copyWith({
    FetchMealDetailsStatus? status,
    String? errorMessage,
    Meal? meal,
  }) {
    return FetchMealDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      meal: meal ?? this.meal,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, meal];
}
/*
sealed class FetchMealDetailsState extends Equatable {
  const FetchMealDetailsState();

  @override
  List<Object> get props => [];
}

final class FetchMealDetailsInitial extends FetchMealDetailsState {}

final class FetchMealDetailsLoading extends FetchMealDetailsState {}

final class FetchMealDetailsSuccess extends FetchMealDetailsState {
  final Meal meal;

  const FetchMealDetailsSuccess(this.meal);
}

final class FetchMealDetailsFailure extends FetchMealDetailsState {
  final String errorMessage;
  const FetchMealDetailsFailure(this.errorMessage);
}
*/
