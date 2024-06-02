import 'package:attendance_keeper/core/constants/assets.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SvgPicture.asset(AppAssets.trueLogo, width: 250.w),
      ),
    );
  }
}
