import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure,List<String?>?>> getLast7DaysWork(NoParams noParams);
}
