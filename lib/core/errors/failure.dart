import 'package:easy_localization/easy_localization.dart';
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
  List<Object?> get props => [];

  @override
  String get message => tr('Invalid_Email');
}

class InvalidCredential extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('Invalid_Credential');
}

class WrongPassword extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('Wrong_Password');
}

class UseNotFound extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('User_Not_Found');
}

class UserDisabled extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('User_Disabled');
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('No_Internet_Connection');
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('Server_Failure');
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => tr('Cache_Failure');
}