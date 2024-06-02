import 'package:attendance_keeper/core/routers/routes.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_navigator.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_counter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.workingDay});

  final WorkingDay workingDay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.allSlotsInDay,
          arguments: workingDay,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: const BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMEEEEd('ar').format(workingDay.dateTime),
                    style: AppTextStyles.bold14,
                  ),
                  verticalSpacing(10),
                  Row(
                    children: [
                      Text(
                        '${tr('total_hours')} :',
                        style: AppTextStyles.semiBold12
                            .copyWith(color: AppColors.appPrimary),
                      ),
                      horizontalSpacing(5),
                      Text(
                        WorkingHoursCounter.hoursAndMinutesAndSeconds(
                                workingDay.totalWorkingHours)
                            .toString(),
                        style: AppTextStyles.bold12
                            .copyWith(color: AppColors.greyDark),
                      ),
                    ],
                  ),
                  verticalSpacing(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tr('today_assignments')} :',
                        style: AppTextStyles.semiBold12
                            .copyWith(color: AppColors.appPrimary),
                      ),
                      verticalSpacing(5),
                      ...workingDay.getAllTasks().map((e) {
                        return Text(
                          '- $e',
                          style: AppTextStyles.semiBold12.copyWith(
                            color: AppColors.greyDark,
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15.r,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
