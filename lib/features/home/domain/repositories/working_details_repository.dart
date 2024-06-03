import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class WorkingDetailsRepository {
  Future<Either<Failure, Unit>> startWork(NoParams noParams);
  Future<Either<Failure, Unit>> endWork(EndWorkParams endWorkParams);
  Future<Either<Failure, (int, bool)>> getTotalWorkingHours(DateTime dateTime);
  Future<Either<Failure, UserEntity>> getUserData(NoParams noParams);
}

class EndWorkParams {
  final List<String> tasks;

  const EndWorkParams({required this.tasks});

  Map<String, dynamic> toDocument() {
    return {
      'tasks': tasks,
    };
  }
}
