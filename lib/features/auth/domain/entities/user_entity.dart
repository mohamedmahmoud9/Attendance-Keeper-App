import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String jobTitle;
  final String email;
  final String userId;
  final String? lastSlotId;
  final String? lastStartTime;

  const UserEntity({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.userId,
    required this.lastSlotId,
    required this.lastStartTime,
  });

  @override
  List<Object?> get props => [name, email, userId, jobTitle , lastSlotId, lastStartTime];
}
