import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class GetCreateCurrentUserUsecase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
