import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRemoteDataSource {
  Future<bool> isSignedIn();
  Future<void> signin(UserEntity userEntity);
  Future<void> signup(UserEntity userEntity);
  Future<void> signout();
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<bool> isSignedIn() async => auth.currentUser != null;

  @override
  Future<void> signin(UserEntity userEntity) async =>
      await auth.signInWithEmailAndPassword(
        email: userEntity.email!,
        password: userEntity.password!,
      );

  @override
  Future<void> signup(UserEntity userEntity) async =>
      await auth.createUserWithEmailAndPassword(
        email: userEntity.email!,
        password: userEntity.password!,
      );

  @override
  Future<void> signout() async => await auth.signOut();
}
