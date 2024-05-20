import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.jobTitle,
    required super.email,
    required super.password,
    required super.confirmPassword,
    required super.uid,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot['name'],
      jobTitle: documentSnapshot['jobTitle'],
      email: documentSnapshot['email'],
      password: documentSnapshot['password'],
      confirmPassword: documentSnapshot['confirmPassword'],
      uid: documentSnapshot['uid'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'jobTitle': jobTitle,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'uid': uid,
    };
  }
}
