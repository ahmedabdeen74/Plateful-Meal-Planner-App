part of 'fetch_meals_cubit.dart';


enum FetchMealsStatus { initial, loading, loaded, error }

class FetchMealsState extends Equatable {
  final FetchMealsStatus status;
  final String? errorMessage;
  final List<Meal>? meals;

  const FetchMealsState({
    required this.status,
    this.errorMessage,
    this.meals,
  });

  FetchMealsState copyWith({
    FetchMealsStatus? status,
    String? errorMessage,
    List<Meal>? meals,
  }) {
    return FetchMealsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      meals: meals ?? this.meals,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, meals];
}
/*enum MealsStatus { initial, loading, loaded, error }

class FetchMealsState {
  final MealsStatus status;
  final String? errorMessage;
  final List<Meal>? meals;

  const FetchMealsState({required this.status, this.errorMessage,this.meals});

  FetchMealsState copyWith({MealsStatus? status, String? errorMessage, List<Meal>? meals}) {
    return FetchMealsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      meals: meals ?? this.meals,
    );
  }
}
*/

/* 
sealed class FetchMealsState extends Equatable {
  const FetchMealsState();

  @override
  List<Object> get props => [];
}

final class FetchMealsInitial extends FetchMealsState {}

final class FetchMealsLoading extends FetchMealsState {}

final class FetchMealsSuccess extends FetchMealsState {
  final List<Meal> meals;

  const FetchMealsSuccess(this.meals);
}

final class FetchMealsFailure extends FetchMealsState {
  final String errorMessage;

  const FetchMealsFailure(this.errorMessage);
}
*/
