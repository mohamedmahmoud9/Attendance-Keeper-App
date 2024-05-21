import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase {
  final FirebaseRepository firebaseRepository;

  SignInUseCase({required this.firebaseRepository});

  Future<Either<Failure, Unit>> call(SignInParams signInParams) async {
    return await firebaseRepository.signin(signInParams);
  }
}
