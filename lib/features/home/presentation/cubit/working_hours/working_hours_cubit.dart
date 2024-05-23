import 'package:attendance_keeper/features/home/domain/usecases/get_total_working_hours_usecase.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_counter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'working_hours_state.dart';

class WorkingHoursCubit extends Cubit<WorkingHoursState> {
  final GetTotalWorkingHoursUseCase getTotalWorkingHoursUseCase;

  WorkingHoursCubit({required this.getTotalWorkingHoursUseCase})
      : super(WorkingHoursInitial());

  Future<void> getTotalWorkingHours() async {
    emit(WorkingHoursLoading());

    final result = await getTotalWorkingHoursUseCase(DateTime.now());
    result.fold((failure) {
      emit(WorkingHoursFailure(message: failure.message));
    }, (totalWorkingHours) {
      emit(WorkingHoursSuccess(totalWorkingHours: totalWorkingHours.$1));
      WorkingHoursCounter.setInitialSeconds(totalWorkingHours.$1);
      if (totalWorkingHours.$2) {
        WorkingHoursCounter.autoIncrement();
      }
    });
  }
}
