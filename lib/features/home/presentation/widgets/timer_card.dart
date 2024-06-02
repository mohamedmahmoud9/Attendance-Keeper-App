import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerCard extends StatefulWidget {
  final String hoursOrMinutesOrSeconds;
  final String dateSection;
  const TimerCard({
    super.key,
    required this.hoursOrMinutesOrSeconds,
    required this.dateSection,
  });

  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.h,
          width: 70.w,
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
          decoration: BoxDecoration(
            color: AppColors.greyLight,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(widget.hoursOrMinutesOrSeconds,
                style: AppTextStyles.medium24
                    .copyWith(color: AppColors.black, fontSize: 40.sp)),
          ),
        ),
        verticalSpacing(5),
        Text(tr(widget.dateSection), style: AppTextStyles.semiBold14),
      ],
    );
  }
}
