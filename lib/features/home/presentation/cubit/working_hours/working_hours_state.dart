part of 'working_hours_cubit.dart';

sealed class WorkingHoursState extends Equatable {
  final bool isStartWork;
  const WorkingHoursState(this.isStartWork);

  WorkingHoursState copyWith({bool? isStartWork});
  @override
  List<Object> get props => [isStartWork];
}

final class WorkingHoursInitial extends WorkingHoursState {
  const WorkingHoursInitial(super.isStartWork);

  @override
  WorkingHoursState copyWith({bool? isStartWork}) {
    return WorkingHoursInitial(isStartWork ?? this.isStartWork);
  }
}

final class WorkingHoursLoading extends WorkingHoursState {
  const WorkingHoursLoading(super.isStartWork);

  @override
  WorkingHoursState copyWith({bool? isStartWork}) {
    return WorkingHoursLoading(isStartWork ?? this.isStartWork);
  }
}

final class WorkingHoursSuccess extends WorkingHoursState {
  final int totalWorkingHours;

  const WorkingHoursSuccess(super.isStartWork,
      {required this.totalWorkingHours});

  @override
  WorkingHoursState copyWith({bool? isStartWork}) {
    return WorkingHoursSuccess(isStartWork ?? this.isStartWork,
        totalWorkingHours: totalWorkingHours);
  }
}

final class WorkingHoursFailure extends WorkingHoursState {
  final String message;

  const WorkingHoursFailure(super.isStartWork, {required this.message});

  @override
  List<Object> get props => [message];

  @override
  WorkingHoursState copyWith({bool? isStartWork}) {
    return WorkingHoursFailure(isStartWork ?? this.isStartWork,
        message: message);
  }
}
