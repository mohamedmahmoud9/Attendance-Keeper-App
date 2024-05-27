import 'package:attendance_keeper/core/routers/routes.dart';
import 'package:attendance_keeper/core/widgets/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      context.pushNamed(Routes.homeScreen);
    } else if (index == 1) {
      context.pushNamed(Routes.analyticsScreen);
    } else if (index == 2) {
      context.pushNamed(Routes.profileScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavigationBar(
      selectedIndex: _selectedIndex,
      inactiveButtonsFlexFactor: 90,
      backgroundColor: AppColors.greyDark,
      onTabChange: _onItemTapped,
      fontSize: 14.sp,
      textStyle: AppTextStyles.medium14.copyWith(color: AppColors.white),
      navigationBarButtons: <NavigationBarButton>[
        NavigationBarButton(
          backgroundColor: AppColors.appPrimary,
          text: tr('home_page'),
          icon: Icons.home,
        ),
        NavigationBarButton(
          backgroundColor: AppColors.appPrimary,
          text: tr('analytics_page'),
          icon: Icons.analytics_outlined,
        ),
        NavigationBarButton(
          backgroundColor: AppColors.appPrimary,
          text: tr('profile_page'),
          icon: Icons.person,
        ),
      ],
    );
  }
}
