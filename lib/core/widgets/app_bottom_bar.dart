import 'package:attendance_keeper/features/home/presentation/cubit/navigation_bar/navigation_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return ResponsiveNavigationBar(
          selectedIndex: state.currentTab,
          inactiveButtonsFlexFactor: 90,
          backgroundColor: AppColors.greyDark,
          onTabChange: (int index) =>
              context.read<NavigationBarCubit>().updateIndex(index),
          fontSize: 14.sp,
          textStyle: AppTextStyles.medium14.copyWith(color: AppColors.white),
          navigationBarButtons: context.read<NavigationBarCubit>().tabs,
        );
      },
    );
  }
}
