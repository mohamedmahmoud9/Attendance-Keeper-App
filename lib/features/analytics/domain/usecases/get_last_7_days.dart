import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:dartz/dartz.dart';

class GetLast7DaysUseCase extends Usecase<List<String?>?, NoParams> {
  final AnalyticsRepository analyticsRepository;

  GetLast7DaysUseCase({required this.analyticsRepository});
  @override
  Future<Either<Failure, List<String?>?>> call(NoParams params) {
    return analyticsRepository.getLast7DaysWork(params);
  }
}
