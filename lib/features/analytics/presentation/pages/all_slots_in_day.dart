import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';
import 'package:attendance_keeper/features/analytics/presentation/widgets/slots_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllSlotsInDay extends StatelessWidget {
  final WorkingDay workingDay;
  const AllSlotsInDay({super.key, required this.workingDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          titleTextStyle: AppTextStyles.bold16,
          backgroundColor: AppColors.appPrimary,
          foregroundColor: AppColors.white,
          title: Text(DateFormat.yMMMMEEEEd('ar')
              .format(workingDay.dateTime)
              .toString())),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star_outline_rounded,
                      color: AppColors.appPrimary, size: 20.sp),
                  horizontalSpacing(3),
                  Text(
                    '${tr('total_slots')} : ',
                    style: AppTextStyles.bold14
                        .copyWith(color: AppColors.appPrimary),
                  ),
                  horizontalSpacing(5),
                  Text(
                    workingDay.daySlots.length.toString(),
                    style: AppTextStyles.bold16,
                  ),
                ],
              ),
              verticalSpacing(15),
              Expanded(

                child: ListView.separated(
                  itemCount: workingDay.daySlots.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return verticalSpacing(7);
                  },
                  itemBuilder: (context, index) {
                    return SlotsCard(
                        start: workingDay.daySlots[index].start,
                        end: workingDay.daySlots[index].end,
                        tasks: workingDay.daySlots[index].tasks);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
