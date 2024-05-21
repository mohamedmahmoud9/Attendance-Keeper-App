import 'package:attendance_keeper/features/auth/data/models/user_model.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRemoteDataSource {
  Future<bool> isSignedIn();
  Future<Unit> signin(SignInParams signInParams);
  Future<Unit> signup(SignUpParams signUpParams);
  Future<Unit> signout();
  Future<String?> getCurrentUserId();
  Future<UserEntity> getCreateCurrentUser(SignUpParams signUpParams);
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<bool> isSignedIn() async => auth.currentUser != null;

  @override
  Future<Unit> signin(SignInParams signInParams) async {
    try {
     await auth.signInWithEmailAndPassword(
        email: signInParams.email,
        password: signInParams.password,
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> signup(SignUpParams signUpParams) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: signUpParams.email,
        password: signUpParams.password,
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
  Future<UserEntity> getCreateCurrentUser(SignUpParams signUpParams) async {
    try {
      final userCollectionRef = firestore.collection("users");
      final userId = await getCurrentUserId();
      if(userId == null) throw Exception();
      final userSnapshot = await userCollectionRef.doc(userId).get();
      if (!userSnapshot.exists) {
        final newUser = UserModel(
          name: signUpParams.name,
          email: signUpParams.email,
          jobTitle: signUpParams.jobTitle,
          userId: userId,
        );
        await userCollectionRef.doc(userId).set(newUser.toDocument());
      }
      return UserModel.fromSnapshot(userSnapshot);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getCurrentUserId() async => auth.currentUser?.uid;
}
