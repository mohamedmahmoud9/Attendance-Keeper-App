import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AutoSignInUsecase extends Usecase<User, NoParams> {
  final FirebaseRepository firebaseRepository;

  AutoSignInUsecase({required this.firebaseRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return firebaseRepository.autoSignin(params);
  }
}
