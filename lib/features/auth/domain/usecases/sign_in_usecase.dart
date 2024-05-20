import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase {
  final FirebaseRepository firebaseRepository;

  SignInUseCase({required this.firebaseRepository});

  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await firebaseRepository.signin(userEntity);
  }
}
