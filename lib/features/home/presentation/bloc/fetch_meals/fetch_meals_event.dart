import 'package:equatable/equatable.dart';

abstract class FetchMealsEvent extends Equatable {
  const FetchMealsEvent();

  @override
  List<Object?> get props => [];
}

class FetchMealsRequested extends FetchMealsEvent {
  final int count;

  const FetchMealsRequested({required this.count});

  @override
  List<Object?> get props => [count];
}
