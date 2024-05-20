import 'package:attendance_keeper/features/auth/data/models/user_model.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRemoteDataSource {
  Future<bool> isSignedIn();
  Future<Unit> signin(UserEntity userEntity);
  Future<Unit> signup(UserEntity userEntity);
  Future<Unit> signout();
  Future<String?> getCurrentUserId();
  Future<Unit> getCreateCurrentUser(UserEntity user);
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<bool> isSignedIn() async => auth.currentUser != null;

  @override
  Future<Unit> signin(UserEntity userEntity) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: userEntity.email!,
        password: userEntity.password!,
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> signup(UserEntity userEntity) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: userEntity.email!,
        password: userEntity.password!,
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> signout() async {
    try {
      await auth.signOut();
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUserId();
    userCollectionRef.doc(uid).get().then(
      (value) {
        final newUser = UserModel(
                userId: user.userId,
                jobTitle: user.jobTitle,
                email: user.email,
                name: user.name,
                password: user.password,
                confirmPassword: user.confirmPassword)
            .toDocument();
        if (!value.exists) {
          userCollectionRef.doc(uid).set(newUser);
        }
      },
    );
    return unit;
  }

  @override
  Future<String?> getCurrentUserId() async => auth.currentUser?.uid;
}
