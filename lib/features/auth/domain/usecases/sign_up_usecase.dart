import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';

class SignUpUseCase {

  final FirebaseRepository firebaseRepository;

  SignUpUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity userEntity) async {
    return await firebaseRepository.signup(userEntity);
  }
}