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
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
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
          TextField(
            // controller: ,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: tr('enter_today_tasks'),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                borderSide: BorderSide(
                  width: 1.w,
                  color: AppColors.greyDark,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                borderSide: BorderSide(
                  width: 1.w,
                  color: AppColors.appPrimary,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            onChanged: (value) {},
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
          verticalSpacing(20),
          // verticalSpacing(50),
          // BlocConsumer<SignOutCubit, SignOutState>(
          //   listener: (context, state) {
          //     if (state is SignOutError) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text(state.message),
          //         ),
          //       );
          //     }
          //   },
          //   builder: (context, state) {
          //     if (state is SignOutLoading) {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           color: AppColors.appPrimary,
          //         ),
          //       );
          //     }
          //     return AppTextButton(
          //       buttonText: tr('sign_out'),
          //       onPressed: () {
          //         context.read<SignOutCubit>().signOut();
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
