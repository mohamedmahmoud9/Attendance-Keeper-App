import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';

class IsSignedInUseCase {

  final FirebaseRepository firebaseRepository;

  IsSignedInUseCase({required this.firebaseRepository});

  Future<bool> call() async {
    return await firebaseRepository.isSignedIn();
  }
}