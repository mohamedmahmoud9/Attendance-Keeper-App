import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';

abstract class AnalyticsRepository {
  Stream<List<WorkingDay>> getLast7DaysWork(NoParams noParams);
}
