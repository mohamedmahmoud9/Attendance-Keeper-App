import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase extends Usecase<UserCredential, SignUpParams> {
  final FirebaseRepository firebaseRepository;

  SignUpUseCase({required this.firebaseRepository});
  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await firebaseRepository.signup(params);
  }
}
