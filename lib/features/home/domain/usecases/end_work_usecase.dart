import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';

class EndWorkUseCase extends Usecase<Unit, EndWorkParams> {
  final WorkingDetailsRepository workingDetailsRepository;

  EndWorkUseCase({required this.workingDetailsRepository});

  @override
  Future<Either<Failure, Unit>> call(EndWorkParams params) async {
    return await workingDetailsRepository.endWork(params);
  }
}
