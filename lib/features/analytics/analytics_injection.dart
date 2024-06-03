import 'package:attendance_keeper/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:attendance_keeper/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:attendance_keeper/features/analytics/domain/usecases/get_all_work_days.dart';
import 'package:attendance_keeper/injection_container.dart';

Future<void> initAnalytics() async {
  // Cubits
  // sl.registerLazySingleton<Last7DaysCubit>(
  //     () => Last7DaysCubit(getLast7DaysUseCase: sl()));

  // UseCases
  sl.registerLazySingleton<GetAllWorkDaysUseCase>(
      () => GetAllWorkDaysUseCase(analyticsRepository: sl()));

  // Repositories
  sl.registerLazySingleton<AnalyticsRepository>(() => AnalyticsRepositoryImpl(
        analyticsRemoteDataSource: sl(),
        auth: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<AnalyticsRemoteDataSource>(
      () => AnalyticsRemoteDataSourceImpl(firestore: sl()));
}
