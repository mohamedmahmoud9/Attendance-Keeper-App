import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

abstract class WorkingDetailsRepository {
  Future<Either<Failure, Unit>> startWork(NoParams noParams);
  Future<Either<Failure, Unit>> endWork(NoParams noParams);
  Future<Either<Failure, (int, bool)>> getTotalWorkingHours(DateTime dateTime);
  Future<Either<Failure, Map<String, dynamic>?>> getUserData(NoParams noParams);
}