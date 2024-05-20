import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';

class GetCurrentUserIdUseCase {

  final FirebaseRepository repository;

  GetCurrentUserIdUseCase({required this.repository});

  Future<String> call()async{
    return repository.getCurrentUId();
  }
}