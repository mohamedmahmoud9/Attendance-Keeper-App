import 'package:attendance_keeper/core/errors/exception.dart';
import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:dartz/dartz.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;
  AnalyticsRepositoryImpl({required this.analyticsRemoteDataSource});

  @override
  Future<Either<Failure, List<String?>?>> getLast7DaysWork(
      NoParams params) async {
    try {
      final List<String?>? last7Days =
          await analyticsRemoteDataSource.getLast7DaysWork();
      return Right(last7Days);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}
