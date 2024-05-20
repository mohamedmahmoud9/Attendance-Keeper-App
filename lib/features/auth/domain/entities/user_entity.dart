import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? jobTitle;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? uid;

  const UserEntity({
    this.name,
    this.jobTitle,
    this.email,
    this.password,
    this.confirmPassword,
    this.uid,
  });

  @override
  List<Object?> get props =>
      [name, email, password, uid, confirmPassword, jobTitle];
}
