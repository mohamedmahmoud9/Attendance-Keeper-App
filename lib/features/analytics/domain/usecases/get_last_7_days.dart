import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';

import '../entities/working_day.dart';

class GetLast7DaysUseCase extends StreamUsecase<List<WorkingDay>, NoParams> {
  final AnalyticsRepository analyticsRepository;

  GetLast7DaysUseCase({required this.analyticsRepository});

  @override
  Stream<List<WorkingDay>> call(NoParams params) =>
      analyticsRepository.getLast7DaysWork(NoParams());
}
