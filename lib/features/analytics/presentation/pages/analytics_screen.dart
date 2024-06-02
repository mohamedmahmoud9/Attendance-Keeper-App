import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';
import 'package:attendance_keeper/features/analytics/presentation/widgets/date_card.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/usecases/get_last_7_days.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: AppColors.appPrimary, size: 20.sp),
                horizontalSpacing(5),
                Text(
                  '${tr('working_details')} :',
                  style: AppTextStyles.bold16
                      .copyWith(color: AppColors.appPrimary),
                ),
              ],
            ),
            verticalSpacing(15),
            Expanded(
              child: StreamBuilder<List<WorkingDay>>(
                stream: sl<GetLast7DaysUseCase>().call(NoParams()),
                initialData: const [],
                builder: (BuildContext context,
                    AsyncSnapshot<List<WorkingDay>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(tr('error')),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(tr('you_didnt_work_last_7_days')),
                      );
                    }
                    return ListView.separated(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return verticalSpacing(7);
                      },
                      itemBuilder: (context, index) {
                        return DateCard(workingDay: snapshot.data![index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
