import 'package:attendance_keeper/core/routers/app_router.dart';
import 'package:attendance_keeper/features/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrueAttendanceKeeperApp extends StatelessWidget {
  final AppRouter appRouter;

  const TrueAttendanceKeeperApp({super.key, required this.appRouter});
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
        onGenerateRoute : appRouter.generateRoute,
      ),
    );
  }
}
