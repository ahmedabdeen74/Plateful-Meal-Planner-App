part of 'fetch_filter_area_cubit.dart';

sealed class FetchFilterAreaState extends Equatable {
  const FetchFilterAreaState();

  @override
  List<Object> get props => [];
}

final class FetchFilterAreaInitial extends FetchFilterAreaState {}

final class FetchFilterAreaLoading extends FetchFilterAreaState {}

final class FetchFilterAreaSuccess extends FetchFilterAreaState {
  final List<Meal> filterArea;

  const FetchFilterAreaSuccess({required this.filterArea});
}

final class FetchFilterAreaFailure extends FetchFilterAreaState {
  final String errMessage;

  const FetchFilterAreaFailure({required this.errMessage});
}
