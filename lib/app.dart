import 'package:attendance_keeper/core/routers/app_router.dart';
import 'package:attendance_keeper/features/auth/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/auto_sign_in/auto_sign_in_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signin_screen.dart';
import 'package:attendance_keeper/features/home/presentation/pages/home_screen.dart';
import 'package:attendance_keeper/features/splash/splash_screen.dart';
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
        ],
        child: MaterialApp(
          title: 'True Attendance Keeper',
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AutoSignInCubit, AutoSignInState>(
            builder: (context, state) {
              if (state is AutoSignInSuccess) {
                return const HomeScreen();
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
