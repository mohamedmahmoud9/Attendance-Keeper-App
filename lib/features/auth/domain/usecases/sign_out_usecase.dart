import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase {
  final FirebaseRepository firebaseRepository;

  SignOutUseCase({required this.firebaseRepository});

  Future<Either<Failure, Unit>> call() async {
    return await firebaseRepository.signout();
  }
}
