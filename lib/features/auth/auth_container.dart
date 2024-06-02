import 'package:attendance_keeper/features/auth/data/datasources/firebase_remote_data_source.dart';
import 'package:attendance_keeper/features/auth/data/repositories/firebase_repository_impl.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/auto_sign_in.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/auto_sign_in/auto_sign_in_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';

Future<void> initAuth() async {
  // Cubits
  sl.registerLazySingleton<SignInCubit>(() => SignInCubit(signInUseCase: sl()));
  sl.registerLazySingleton<SignUpCubit>(() => SignUpCubit(signUpUseCase: sl()));
  sl.registerLazySingleton<AutoSignInCubit>(
      () => AutoSignInCubit(autoSignInUsecase: sl()));
  sl.registerLazySingleton<SignOutCubit>(
      () => SignOutCubit(signOutUseCase: sl()));

  // UseCases
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton<AutoSignInUsecase>(
      () => AutoSignInUsecase(firebaseRepository: sl()));

  // Repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(auth: sl(), firestore: sl()));
}
