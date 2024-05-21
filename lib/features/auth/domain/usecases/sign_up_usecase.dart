import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final FirebaseRepository firebaseRepository;

  SignUpUseCase({required this.firebaseRepository});

  Future<Either<Failure, Unit>> call(SignUpParams signUpParams) async {
    return await firebaseRepository.signup(signUpParams);
  }
}
