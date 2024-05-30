import 'package:attendance_keeper/core/constants/assets.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/profile/presentation/widgets/personal_details_list.dart';
import 'package:attendance_keeper/features/profile/presentation/widgets/sign_out_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300.h,
            decoration: BoxDecoration(
              color: AppColors.appPrimary,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(110.r),
                    child: Image.asset(AppAssets.pro, width: 110.w),
                  ),
                  verticalSpacing(10),
                  Text(tr('my_personal_account'),
                      style: AppTextStyles.bold18
                          .copyWith(color: AppColors.white)),
                ],
              ),
            ),
          ),
          const PersonalDetailsList(),
          verticalSpacing(20),
          const SignOutButton(),
        ],
      ),
    );
  }
}
