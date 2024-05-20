import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';

class SignOutUseCase {
  final FirebaseRepository firebaseRepository;

  SignOutUseCase({required this.firebaseRepository});

  Future<void> call() async {
    return await firebaseRepository.signout();
  }
}
