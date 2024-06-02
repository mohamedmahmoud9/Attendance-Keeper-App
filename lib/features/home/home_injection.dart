import 'package:attendance_keeper/features/home/domain/usecases/end_work_usecase.dart';
import 'package:attendance_keeper/features/home/domain/usecases/get_total_working_hours_usecase.dart';
import 'package:attendance_keeper/features/home/domain/usecases/get_user_data_usecase.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/end_work/end_work_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/navigation_bar/navigation_bar_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/user_data/user_data_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:attendance_keeper/features/home/data/datasources/working_details_remote_data_source.dart';
import 'package:attendance_keeper/features/home/data/repositories/working_details_repository_impl.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:attendance_keeper/features/home/domain/usecases/start_work_usecase.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/start_work/start_work_cubit.dart';

Future<void> initHome() async {
  // Cubits
  sl.registerLazySingleton<StartWorkCubit>(
      () => StartWorkCubit(startWorkUseCase: sl()));
  sl.registerFactory<EndWorkCubit>(() => EndWorkCubit(endWorkUseCase: sl()));
  sl.registerLazySingleton<WorkingHoursCubit>(
      () => WorkingHoursCubit(getTotalWorkingHoursUseCase: sl()));
  sl.registerLazySingleton<UserDataCubit>(
      () => UserDataCubit(getUserDataUseCase: sl()));
  sl.registerLazySingleton<NavigationBarCubit>(() => NavigationBarCubit());

  // UseCases
  sl.registerLazySingleton<StartWorkUseCase>(
      () => StartWorkUseCase(workingDetailsRepository: sl()));
  sl.registerLazySingleton<EndWorkUseCase>(
      () => EndWorkUseCase(workingDetailsRepository: sl()));
  sl.registerLazySingleton<GetTotalWorkingHoursUseCase>(
      () => GetTotalWorkingHoursUseCase(workingDetailsRepository: sl()));
  sl.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(workingDetailsRepository: sl()));

  // Repositories
  sl.registerLazySingleton<WorkingDetailsRepository>(
      () => WorkingDetailsRepositoryImpl(
            workingDetailsRemoteDataSource: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<WorkingDetailsRemoteDataSource>(
      () => WorkingDetailsRemoteDataSourceImpl(auth: sl(), firestore: sl()));
}
