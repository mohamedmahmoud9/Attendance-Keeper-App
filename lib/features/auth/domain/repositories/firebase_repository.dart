import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignedIn();
  Future<void> signin(UserEntity userEntity);
  Future<void> signup(UserEntity userEntity);
  Future<void> signout();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
}
