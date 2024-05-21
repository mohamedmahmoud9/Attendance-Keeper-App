import 'package:attendance_keeper/core/routers/routes.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signin_screen.dart';
import 'package:attendance_keeper/features/auth/presentation/pages/signup_screen.dart';
import 'package:attendance_keeper/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
