import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/home/domain/usecases/start_work_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'start_work_state.dart';

class StartWorkCubit extends Cubit<StartWorkState> {
  final StartWorkUseCase startWorkUseCase;

  StartWorkCubit({required this.startWorkUseCase}) : super(StartWorkInitial());

  Future<void> startWork() async {
    emit(StartWorkLoading());
    final result = await startWorkUseCase(NoParams());
    result.fold((failure) {
      emit(StartWorkFailure(message: failure.message));
    }, (r) {
      emit(StartWorkSuccess());
    });
  }
}
