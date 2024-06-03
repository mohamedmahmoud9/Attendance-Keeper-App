import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';

abstract class AnalyticsRepository {
  Stream<List<WorkingDay>> getAllWorkDays(AllWorkDaysParams noParams);
}

sealed class AllWorkDaysParams {}

final class AllWorkDaysUserParams extends AllWorkDaysParams {}

final class AllWorkDaysHRParams extends AllWorkDaysParams {
  final String uid;

  AllWorkDaysHRParams({required this.uid});
}
