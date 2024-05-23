part of 'working_hours_cubit.dart';

sealed class WorkingHoursState extends Equatable {
  const WorkingHoursState();

  @override
  List<Object> get props => [];
}

final class WorkingHoursInitial extends WorkingHoursState {}

final class WorkingHoursLoading extends WorkingHoursState {}

final class WorkingHoursSuccess extends WorkingHoursState {
  final int totalWorkingHours;

  const WorkingHoursSuccess({required this.totalWorkingHours});

  @override
  List<Object> get props => [totalWorkingHours];
  }

final class WorkingHoursFailure extends WorkingHoursState {
  final String message;

  const WorkingHoursFailure({required this.message});

  @override
  List<Object> get props => [message];
}
