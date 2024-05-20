import 'package:attendance_keeper/features/auth/data/datasources/firebase_remote_data_source.dart';
import 'package:attendance_keeper/features/auth/data/repositories/firebase_repository_impl.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/get_create_current_user_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/get_current_user_id_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/is_signed_in_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/user/user_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isSignedInUseCase: sl(),
        signOutUseCase: sl(),
        getCurrentUserIdUseCase: sl(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: sl(),
        signInUseCase: sl(),
        signUpUseCase: sl(),
      ));

  // UseCases
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl()));
  sl.registerLazySingleton<GetCurrentUserIdUseCase>(
      () => GetCurrentUserIdUseCase(repository: sl()));
  sl.registerLazySingleton<IsSignedInUseCase>(
      () => IsSignedInUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(firebaseRepository: sl()));

  // Repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(auth: sl(), firestore: sl()));

  // Externals
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
