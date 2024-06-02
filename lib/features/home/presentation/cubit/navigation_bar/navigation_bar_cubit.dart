import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
part 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(const NavigationBarState(currentTab: 0));

  List<NavigationBarButton> tabs = <NavigationBarButton>[
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
  ];

  void updateIndex(int tab) {
    emit(NavigationBarState(currentTab: tab));
  }
}
