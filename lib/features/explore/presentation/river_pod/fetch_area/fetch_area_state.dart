import 'package:equatable/equatable.dart';
import 'package:meal_planner/features/explore/data/models/area/meal.dart';

sealed class FetchAreaState extends Equatable {
  const FetchAreaState();

  @override
  List<Object> get props => [];
}

final class FetchAreaInitial extends FetchAreaState {}

final class FetchAreaLoading extends FetchAreaState {}

final class FetchAreaSuccess extends FetchAreaState {
  final List<AreaMeal> areas;
  const FetchAreaSuccess({required this.areas});
}

final class FetchAreaFailure extends FetchAreaState {
  final String errMessage;
  const FetchAreaFailure({required this.errMessage});
}
