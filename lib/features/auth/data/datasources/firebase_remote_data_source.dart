import 'package:attendance_keeper/core/errors/exception.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/data/models/user_model.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRemoteDataSource {
  Future<UserCredential> signin(SignInParams signInParams);
  Future<User> autoSignin(NoParams params);
  Future<UserCredential> signup(SignUpParams signUpParams);
  Future<Unit> signout(NoParams params);
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<UserCredential> signin(SignInParams signInParams) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: signInParams.email,
        password: signInParams.password,
      );
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signup(SignUpParams signUpParams) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: signUpParams.email,
        password: signUpParams.password,
      );
      final userCollectionRef = firestore.collection("users'data");
      final userId = userCredential.user?.uid;
      if (userId == null) throw Exception();
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
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> autoSignin(NoParams params) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw AutoSignInException();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> signout(NoParams params) async {
    try {
      await auth.signOut();
      return unit;
    } catch (e) {
      rethrow;
    }
  }
}
