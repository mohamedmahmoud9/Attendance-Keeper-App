import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

abstract class WorkingDetailsRepository {
  Future<Either<Failure, Unit>> startWork(NoParams noParams);
}

