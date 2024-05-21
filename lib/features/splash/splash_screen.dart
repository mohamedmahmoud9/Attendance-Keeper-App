import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:attendance_keeper/core/constants/assets.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(milliseconds: 2000),
      splash: SvgPicture.asset(AppAssets.trueLogo, width: 400.w),
      nextScreen: const SignUpScreen(),
      backgroundColor: AppColors.white,
    );
  }
}
