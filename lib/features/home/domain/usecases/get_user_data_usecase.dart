import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserDataUseCase extends Usecase<UserEntity, NoParams> {
  final WorkingDetailsRepository workingDetailsRepository;

  GetUserDataUseCase({required this.workingDetailsRepository});
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await workingDetailsRepository.getUserData(params);
  }
}
