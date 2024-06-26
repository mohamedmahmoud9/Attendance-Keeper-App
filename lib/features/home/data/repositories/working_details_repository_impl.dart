import 'package:attendance_keeper/core/errors/exception.dart';
import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/home/data/datasources/working_details_remote_data_source.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkingDetailsRepositoryImpl implements WorkingDetailsRepository {
  final WorkingDetailsRemoteDataSource workingDetailsRemoteDataSource;
  final FirebaseAuth auth;

  WorkingDetailsRepositoryImpl(
      {required this.workingDetailsRemoteDataSource, required this.auth});
  String? get uid => auth.currentUser?.uid;
  @override
  Future<Either<Failure, Unit>> startWork(NoParams noParams) async {
    try {
      await workingDetailsRemoteDataSource.startWork(uid);
      return const Right(unit);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on AlreadyWorkingException catch (_) {
      return Left(AlreadyWorkingFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> endWork(EndWorkParams endWorkParams) async {
    try {
      await workingDetailsRemoteDataSource.endWork(endWorkParams, uid);
      return const Right(unit);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on NotWorkingException catch (_) {
      return Left(NotWorkingFailure());
    }
  }

  @override
  Future<Either<Failure, (int, bool)>> getTotalWorkingHours(
      DateTime dateTime) async {
    try {
      final int totalWorkingHours = await workingDetailsRemoteDataSource
          .getTotalWorkingHours(dateTime, uid);
      final hasStarted =
          await workingDetailsRemoteDataSource.lastSlotId(uid) != null;
      return Right((totalWorkingHours, hasStarted));
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(NoParams noParams) async {
    try {
      final userData = await workingDetailsRemoteDataSource.getUserData(uid);
      return Right(userData);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}
