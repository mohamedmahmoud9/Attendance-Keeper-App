import 'package:attendance_keeper/core/themes/app_colors.dart';
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
      onTap: () {},
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
                  ),
                  Text(WorkingHoursCounter.hoursAndMinutesAndSeconds(
                          workingDay.totalWorkingHours)
                      .toString()),
                  ...workingDay.getAllTasks().map((e) => Text(e))
                  // Text(slot.start.toDate().toString(),
                  //     style: AppTextStyles.semiBold14),
                  // if (slot.end != null)
                  //   Text(slot.end!.toDate().toString(),
                  //       style: AppTextStyles.semiBold14),
                  // if (slot.tasks != null) Text(slot.tasks!)
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
