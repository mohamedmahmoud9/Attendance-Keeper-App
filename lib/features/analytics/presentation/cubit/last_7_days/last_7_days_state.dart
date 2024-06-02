part of 'last_7_days_cubit.dart';

sealed class Last7DaysState extends Equatable {
  const Last7DaysState();

  @override
  List<Object> get props => [];
}

final class Last7DaysInitial extends Last7DaysState {}

final class Last7DaysLoading extends Last7DaysState {}

final class Last7DaysLoaded extends Last7DaysState {
  final List<String?>? last7Days;
  const Last7DaysLoaded({required this.last7Days});
}

final class Last7DaysError extends Last7DaysState {
  final String message;
  const Last7DaysError({required this.message});
}
