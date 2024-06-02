import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase extends Usecase<Unit, NoParams> {
  final FirebaseRepository firebaseRepository;

  SignOutUseCase({required this.firebaseRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await firebaseRepository.signout(params);
  }
}
