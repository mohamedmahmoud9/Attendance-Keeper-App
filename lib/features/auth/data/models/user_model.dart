import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.jobTitle,
    required super.email,
    required super.userId,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot['name'],
      jobTitle: documentSnapshot['jobTitle'],
      email: documentSnapshot['email'],
      userId: documentSnapshot['userId'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'jobTitle': jobTitle, 
      'email': email,
      'userId': userId,
    };
  }
}
