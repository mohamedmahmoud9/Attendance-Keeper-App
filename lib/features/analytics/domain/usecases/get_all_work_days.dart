import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/domain/repositories/analytics_repository.dart';

import '../entities/working_day.dart';

class GetAllWorkDaysUseCase
    extends StreamUsecase<List<WorkingDay>, AllWorkDaysParams> {
  final AnalyticsRepository analyticsRepository;

  GetAllWorkDaysUseCase({required this.analyticsRepository});

  @override
  Stream<List<WorkingDay>> call(AllWorkDaysParams params) =>
      analyticsRepository.getAllWorkDays(params);
}
