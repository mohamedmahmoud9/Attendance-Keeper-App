import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get message;
}

const String invalidEmail = 'invalid-email';
const String userDisabled = 'user-disabled';
const String wrongPassword = 'wrong-password';
const String userNotFound = 'user-not-found';
const String invalidCredential = 'invalid-credential';

class FirbaseAuthFailureHelper {
  static Failure getFailure(String code) {
    switch (code) {
      case invalidEmail:
        return InvalidEmail();
      case userDisabled:
        return UserDisabled();
      case wrongPassword:
        return WrongPassword();
      case userNotFound:
        return UseNotFound();
      case invalidCredential:
        return InvalidCredential();
      default:
        return ServerFailure();
    }
  }
}

class InvalidEmail extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  String get message => 'Invalid Email';
}

class InvalidCredential extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  String get message => 'Invalid Credential';
}

class WrongPassword extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'Wrong Password';
}

class UseNotFound extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'User Not Found';
}

class UserDisabled extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'User Disabled';
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'No Internet Connection';
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'Server Failure';
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'Cache Failure';
}
