import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/home/domain/usecases/end_work_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'end_work_state.dart';

class EndWorkCubit extends Cubit<EndWorkState> {
  final EndWorkUseCase endWorkUseCase;
  EndWorkCubit({required this.endWorkUseCase}) : super(EndWorkInitial());

  Future<void> endWork() async {
    emit(EndWorkLoading());
    final result = await endWorkUseCase(NoParams());
    result.fold((failure) {
      emit(EndWorkFailure(message: failure.message));
    }, (r) {
      emit(EndWorkSuccess());
    });
  }
}
