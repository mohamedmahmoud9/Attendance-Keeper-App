import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;
  AnalyticsRepositoryImpl({required this.analyticsRemoteDataSource});

  @override
  Stream<List<WorkingDay>> getLast7DaysWork(NoParams params) {
    return analyticsRemoteDataSource.getLast7DaysWork();
  }
}
