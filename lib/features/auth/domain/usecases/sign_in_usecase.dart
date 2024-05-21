import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/usecases/usecase.dart';

class SignInUseCase extends Usecase<UserCredential, SignInParams> {
  final FirebaseRepository firebaseRepository;

  SignInUseCase({required this.firebaseRepository});
@override
  Future<Either<Failure, UserCredential>> call(SignInParams params) async {
    return await firebaseRepository.signin(params);
  }
}

