import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.date});

  final String? date;

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
            Wrap(children: [
              Text(date ?? tr('you_didnt_work_last_7_days'),
                  style: AppTextStyles.semiBold14)
            ]),
            const Spacer(),
            date == null
                ? const SizedBox()
                : Icon(
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
