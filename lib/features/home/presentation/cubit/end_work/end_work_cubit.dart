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

  List<String> tasks = [];
  void addTask() {
    if (tasksController.text.isEmpty) {
      return;
    }
    emit(EndWorkLoading());
    tasks.add(tasksController.text);
    clearController();
    showSucessToast('Task Added');
    emit(EndWorkInitial());
  }

  void removeTask(int index) {
    emit(EndWorkLoading());
    tasks.removeAt(index);
    showSucessToast('Task Removed');
    emit(EndWorkSuccess());
  }

  void clearController() {
    tasksController.clear();
  }

  void controllerDispose() {
    tasksController.dispose();
  }

  Future<void> endWork() async {
    emit(EndWorkLoading());
    if (tasksController.text.isNotEmpty) {
      addTask();
    }
    final result = await endWorkUseCase(EndWorkParams(tasks: tasks));
    result.fold((failure) {
      emit(EndWorkFailure(message: failure.message));
    }, (r) {
      tasks.clear();
      emit(EndWorkSuccess());
      if (tasksController.text.isNotEmpty) {
        showSucessToast(tr('added_tasks'));
      } else {
        showSucessToast(tr('end_time_successfully'));
      }
      sl<WorkingHoursCubit>().endWork();
    });
  }
}
