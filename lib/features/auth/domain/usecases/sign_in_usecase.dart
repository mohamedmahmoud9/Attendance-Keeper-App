import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';

class SignInUseCase {

  final FirebaseRepository firebaseRepository;

  SignInUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity userEntity) async {
    return await firebaseRepository.signin(userEntity);
  }
}