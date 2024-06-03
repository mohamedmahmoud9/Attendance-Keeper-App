import 'package:attendance_keeper/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;
  final FirebaseAuth auth;

  AnalyticsRepositoryImpl(
      {required this.analyticsRemoteDataSource, required this.auth});

  @override
  Stream<List<WorkingDay>> getAllWorkDays(AllWorkDaysParams params) {
    switch (params) {
      case AllWorkDaysUserParams _:
        return analyticsRemoteDataSource.getAllWorkDays(
          auth.currentUser?.uid,
        );
      case AllWorkDaysHRParams _:
        return analyticsRemoteDataSource.getAllWorkDays(params.uid);
    }
  }
}
