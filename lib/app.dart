import 'dart:developer';

import 'package:attendance_keeper/core/routers/app_router.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/auto_sign_in/auto_sign_in_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signin_screen.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/end_work/end_work_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/navigation_bar/navigation_bar_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/user_data/user_data_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/pages/nav_screen.dart';
import 'package:attendance_keeper/features/splash/splash_screen.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignInCubit>(
            create: (context) => sl<SignInCubit>(),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => sl<SignUpCubit>(),
          ),
          BlocProvider<AutoSignInCubit>(
            create: (context) => sl<AutoSignInCubit>()..autoSignIn(),
          ),
          BlocProvider<SignOutCubit>(
            create: (context) => sl<SignOutCubit>(),
          ),
          BlocProvider<WorkingHoursCubit>(
              create: (context) =>
                  sl<WorkingHoursCubit>()..getTotalWorkingHours()),
          BlocProvider<NavigationBarCubit>(
            create: (context) => sl<NavigationBarCubit>(),
          ),
          BlocProvider<UserDataCubit>(
            create: (context) => sl<UserDataCubit>()..getUserData(),
          ),
          BlocProvider<EndWorkCubit>(
            create: (context) => sl<EndWorkCubit>(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Cairo',
          ),
          title: 'True Attendance Keeper',
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AutoSignInCubit, AutoSignInState>(
            builder: (context, state) {
              log(state.toString());
              if (state is AutoSignInSuccess) {
                return const NavBarScreen();
              }
              if (state is AutoSignInHRSuccess) {
                return const Scaffold();
              } else if (state is AutoSignInInitial ||
                  state is AutoSignInLoading) {
                return const SplashScreen();
              } else if (state is AutoSignInError) {
                return const SignInScreen();
              }
              return const SplashScreen();
            },
          ),
          locale: const Locale('ar'),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
