import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String jobTitle;
  final String email;
  final String userId;

  const UserEntity({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.userId,
  });

  @override
  List<Object?> get props => [name, email, userId, jobTitle];
}
