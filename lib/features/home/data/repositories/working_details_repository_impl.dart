import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/home/data/datasources/working_details_remote_data_source.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:dartz/dartz.dart';

class WorkingDetailsRepositoryImpl implements WorkingDetailsRepository {
  final WorkingDetailsRemoteDataSource workingDetailsRemoteDataSource;

  WorkingDetailsRepositoryImpl({required this.workingDetailsRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> startWork(NoParams noParams)async{
    try {
       await workingDetailsRemoteDataSource.startWork(noParams);
       return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}