import 'package:attendance_keeper/features/auth/data/datasources/firebase_remote_data_source.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<bool> isSignedIn() => firebaseRemoteDataSource.isSignedIn();

  @override
  Future<void> signin(UserEntity userEntity) async =>
      await firebaseRemoteDataSource.signin(userEntity);

  @override
  Future<void> signup(UserEntity userEntity) async =>
      await firebaseRemoteDataSource.signup(userEntity);

  @override
  Future<void> signout() async => await firebaseRemoteDataSource.signout();

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      await firebaseRemoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async =>
      await firebaseRemoteDataSource.getCurrentUserId();
}
