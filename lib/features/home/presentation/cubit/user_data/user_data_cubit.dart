import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/home/domain/usecases/get_user_data_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final GetUserDataUseCase getUserDataUseCase;
  UserDataCubit( {required this.getUserDataUseCase}) : super(UserDataInitial());

  Future<void> getUserData() async {
    emit(UserDataLoading());
    final result = await getUserDataUseCase(NoParams());
    result.fold(
      (l) => emit(UserDataError(message: l.message)),
      (r) => emit(UserDataLoaded(user: r)),
    );
  }
}
