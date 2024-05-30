import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/analytics/presentation/widgets/date_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:attendance_keeper/core/widgets/app_toast.dart';
import 'package:attendance_keeper/features/analytics/presentation/cubit/last_7_days/last_7_days_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            BlocProvider<Last7DaysCubit>(
              create: (context) => sl<Last7DaysCubit>()..getLast7Days(),
              child: BlocBuilder<Last7DaysCubit, Last7DaysState>(
                builder: (context, state) {
                  if (state is Last7DaysLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appPrimary,
                      ),
                    );
                  }
                  if (state is Last7DaysError) {
                    return showErorrToast(state.message);
                  }
                  if (state is Last7DaysLoaded) {
                    int listLength;
                    if (state.last7Days == null) {
                      listLength = 1;
                    } else if (state.last7Days!.length < 7) {
                      listLength = state.last7Days!.length;
                    } else {
                      listLength = 7;
                    }
                    return ListView.separated(
                      itemCount: listLength,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return verticalSpacing(7);
                      },
                      itemBuilder: (context, index) {
                        return DateCard(date: state.last7Days?[index]);
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
