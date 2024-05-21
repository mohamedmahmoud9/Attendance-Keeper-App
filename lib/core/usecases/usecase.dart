import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract  class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params); 
}
