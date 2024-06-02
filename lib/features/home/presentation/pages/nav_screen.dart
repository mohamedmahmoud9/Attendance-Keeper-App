import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/widgets/app_bottom_bar.dart';
import 'package:attendance_keeper/features/analytics/presentation/pages/analytics_screen.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/navigation_bar/navigation_bar_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/pages/home_screen.dart';
import 'package:attendance_keeper/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<NavigationBarCubit, NavigationBarState>(
        builder: (context, state) {
          switch (state.currentTab) {
            case 0:
              return const HomeScreen();
            case 1:
              return const AnalyticsScreen();
            case 2:
              return const ProfileScreen();
            default:
              return const HomeScreen();
          }
        },
      ),
      bottomNavigationBar: const AppBottomBar(),
    );
  }
}
