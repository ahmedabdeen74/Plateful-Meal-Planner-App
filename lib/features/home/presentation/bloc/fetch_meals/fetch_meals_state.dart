import 'package:equatable/equatable.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';

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

