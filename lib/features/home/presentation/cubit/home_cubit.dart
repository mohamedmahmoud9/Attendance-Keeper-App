import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/home/domain/usecases/start_work_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class StartWorkCubit extends Cubit<StartWorkState> {
  final StartWorkUseCase startWorkUseCase;

  StartWorkCubit({required this.startWorkUseCase}) : super(StartWorkInitial());

  Future<void> startWork() async {
    emit(StartWorkLoading());
    final result = await startWorkUseCase(NoParams());
    result.fold((failure) {
      emit(const StartWorkFailure(message: 'Start Work Failed'));
    }, (r) {
      emit(StartWorkSuccess());
    });
  }
}
