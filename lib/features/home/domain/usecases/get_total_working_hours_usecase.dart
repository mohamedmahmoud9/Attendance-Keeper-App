import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetTotalWorkingHoursUseCase extends Usecase<(int, bool ), DateTime> {
  final WorkingDetailsRepository workingDetailsRepository;

  GetTotalWorkingHoursUseCase({required this.workingDetailsRepository});
  @override
  Future<Either<Failure, (int, bool )>> call(DateTime params) async {
    return await workingDetailsRepository.getTotalWorkingHours(params);
  }
}
