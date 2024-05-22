import 'package:attendance_keeper/injection_container.dart';
import 'package:attendance_keeper/features/home/data/datasources/working_details_remote_data_source.dart';
import 'package:attendance_keeper/features/home/data/repositories/working_details_repository_impl.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:attendance_keeper/features/home/domain/usecases/start_work_usecase.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/home_cubit.dart';



Future<void> initHome() async {
  // Cubits
  sl.registerLazySingleton<StartWorkCubit>(
      () => StartWorkCubit(startWorkUseCase: sl()));

  // UseCases
  sl.registerLazySingleton<StartWorkUseCase>(
      () => StartWorkUseCase(workingDetailsRepository: sl()));

  // Repositories
  sl.registerLazySingleton<WorkingDetailsRepository>(
      () => WorkingDetailsRepositoryImpl(
            workingDetailsRemoteDataSource: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<WorkingDetailsRemoteDataSource>(
      () => WorkingDetailsRemoteDataSourceImpl(auth: sl(), firestore: sl()));

  // Externals

}
