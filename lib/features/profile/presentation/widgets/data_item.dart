import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataItem extends StatelessWidget {
  final IconData icon;
  final String headlineText;
  final String subtitleList;

  const DataItem({
    super.key,
    required this.icon,
    required this.headlineText,
    required this.subtitleList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.appPrimary, size: 20.sp),
              horizontalSpacing(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(headlineText,
                      style: AppTextStyles.bold14
                          .copyWith(color: AppColors.black)),
                  Text(subtitleList, style: AppTextStyles.semiBold14),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
