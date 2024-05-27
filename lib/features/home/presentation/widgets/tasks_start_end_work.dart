import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/widgets/start_and_end_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasksAndStartAndEndWork extends StatelessWidget {
  const TasksAndStartAndEndWork({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.task_alt_rounded,
                  color: AppColors.appPrimary, size: 20.sp),
              horizontalSpacing(5),
              Text(tr('مهام اليوم'), style: AppTextStyles.bold14),
            ],
          ),
          verticalSpacing(7),
          BlocSelector<WorkingHoursCubit, WorkingHoursState, bool>(
            selector: (state) => state.isStartWork,
            builder: (context, isStarted) {
              return TextField(
                readOnly: !isStarted,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: isStarted
                      ? tr('enter_today_tasks')
                      : tr('must_start_to_add_tasks'),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.red,
                    ),
                  ),
                  enabledBorder: isStarted
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: AppColors.greyDark,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: AppColors.red,
                          ),
                        ),
                  focusedBorder: isStarted
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: AppColors.appPrimary,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: Colors.red,
                          ),
                        ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                onChanged: (value) {},
              );
            },
          ),
          verticalSpacing(50),
          BlocSelector<WorkingHoursCubit, WorkingHoursState, bool>(
              selector: (state) => state.isStartWork,
              builder: (context, isStarted) {
                if (isStarted) {
                  return const EndButton();
                } else {
                  return const StartButton();
                }
              }),
        ],
      ),
    );
  }
}
