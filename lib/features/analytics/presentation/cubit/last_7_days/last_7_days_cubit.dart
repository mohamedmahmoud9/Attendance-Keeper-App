import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/domain/usecases/get_last_7_days.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'last_7_days_state.dart';

class Last7DaysCubit extends Cubit<Last7DaysState> {
  final GetLast7DaysUseCase getLast7DaysUseCase;
  Last7DaysCubit({required this.getLast7DaysUseCase})
      : super(Last7DaysInitial());

  Future<void> getLast7Days() async {
    emit(Last7DaysLoading());
    final result = await getLast7DaysUseCase(NoParams());
    result.fold(
      (l) => emit(Last7DaysError(message: l.message)),
      (r) {
        emit(Last7DaysLoaded(last7Days: r));
        debugPrint(r.toString());
      },
    );
  }
}
