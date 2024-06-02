import 'package:attendance_keeper/core/routers/routes.dart';
import 'package:attendance_keeper/features/analytics/domain/entities/working_day.dart';
import 'package:attendance_keeper/features/analytics/presentation/pages/all_slots_in_day.dart';
import 'package:attendance_keeper/features/analytics/presentation/pages/analytics_screen.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signin_screen.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signup_screen.dart';
import 'package:attendance_keeper/features/home/presentation/pages/home_screen.dart';
import 'package:attendance_keeper/features/profile/presentation/pages/profile_screen.dart';
import 'package:attendance_keeper/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      // Splash Screen
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      // Sign in Screen
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );

      // Sign Up Screen
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      // Home Screen
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      // Analytics Screen
      case Routes.analyticsScreen:
        return MaterialPageRoute(
          builder: (context) => const AnalyticsScreen(),
        );

      // Profile Screen
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      // All Slots In Day
      case Routes.allSlotsInDay:
        return MaterialPageRoute(
          builder: (context) => AllSlotsInDay(
            workingDay: arguments as WorkingDay,
          ),
        );

      // Default
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
