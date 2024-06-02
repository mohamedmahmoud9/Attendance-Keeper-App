import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_counter.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/widgets/timer_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat.yMMMMd('ar');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyDark.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 20.r,
                color: AppColors.appPrimary,
              ),
              horizontalSpacing(5),
              Text(
                '${tr('today_date')} :',
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.black,
                ),
              ),
              horizontalSpacing(5),
              Text(dateFormat.format(now), style: AppTextStyles.bold16),
            ],
          ),
          verticalSpacing(10),
          Row(
            children: [
              Icon(
                Icons.access_time_sharp,
                size: 20.r,
                color: AppColors.appPrimary,
              ),
              horizontalSpacing(5),
              Text(
                '${tr('total_working_hours_today')} :',
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Expanded(
            child: Center(
              child: BlocBuilder<WorkingHoursCubit, WorkingHoursState>(
                builder: (context, state) {
                  return StreamBuilder(
                    stream: WorkingHoursCounter.stream,
                    initialData: WorkingHoursCounter.seconds,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              TimerCard(
                                hoursOrMinutesOrSeconds: WorkingHoursCounter
                                        .hoursAndMinutesAndSeconds(
                                            snapshot.data!)
                                    .seconds
                                    .toString()
                                    .padLeft(2, '0'),
                                dateSection: 'seconds',
                              ),
                              verticalSpacing(5),
                            ],
                          ),
                          horizontalSpacing(5),
                          Padding(
                            padding: EdgeInsets.only(bottom: 35.h),
                            child: Text(':',
                                style: AppTextStyles.bold24
                                    .copyWith(fontSize: 30.sp)),
                          ),
                          horizontalSpacing(5),
                          TimerCard(
                            hoursOrMinutesOrSeconds:
                                WorkingHoursCounter.hoursAndMinutesAndSeconds(
                                        snapshot.data!)
                                    .minutes
                                    .toString()
                                    .padLeft(2, '0'),
                            dateSection: 'minutes',
                          ),
                          horizontalSpacing(5),
                          Padding(
                            padding: EdgeInsets.only(bottom: 35.h),
                            child: Text(':',
                                style: AppTextStyles.bold24
                                    .copyWith(fontSize: 30.sp)),
                          ),
                          horizontalSpacing(5),
                          TimerCard(
                            hoursOrMinutesOrSeconds:
                                WorkingHoursCounter.hoursAndMinutesAndSeconds(
                                        snapshot.data!)
                                    .hours
                                    .toString()
                                    .padLeft(2, '0'),
                            dateSection: 'hours',
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
