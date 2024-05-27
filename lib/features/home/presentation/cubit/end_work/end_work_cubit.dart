import 'package:attendance_keeper/core/widgets/app_toast.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:attendance_keeper/features/home/domain/usecases/end_work_usecase.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'end_work_state.dart';

class EndWorkCubit extends Cubit<EndWorkState> {
  final EndWorkUseCase endWorkUseCase;
  EndWorkCubit({required this.endWorkUseCase}) : super(EndWorkInitial());

  TextEditingController tasksController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void clearController() {
    tasksController.clear();
  }

  void controllerDispose() {
    tasksController.dispose();
  }

  Future<void> endWork() async {
    emit(EndWorkLoading());
    final result =
        await endWorkUseCase(EndWorkParams(tasks: tasksController.text));
    result.fold((failure) {
      emit(EndWorkFailure(message: failure.message));
    }, (r) {
      emit(EndWorkSuccess());
      if (tasksController.text.isNotEmpty) {
        showSucessToast(tr('added_tasks'));
      } else {
        showSucessToast(tr('end_time_successfully'));
      }
      sl<WorkingHoursCubit>().endWork();
      clearController();
    });
  }
}
