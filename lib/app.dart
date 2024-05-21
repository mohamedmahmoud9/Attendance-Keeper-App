import 'package:attendance_keeper/features/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrueAttendanceKeeperApp extends StatelessWidget {
  const TrueAttendanceKeeperApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'True Attendance Keeper',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        locale: const Locale('ar'),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
      ),
    );
  }
}
