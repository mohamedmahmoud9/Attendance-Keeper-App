import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/widgets/app_bottom_bar.dart';
import 'package:attendance_keeper/features/home/presentation/widgets/home_card.dart';
import 'package:attendance_keeper/features/home/presentation/widgets/intro_card.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/widgets/tasks_start_end_work.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250.h,
                      margin: EdgeInsets.only(bottom: 100.h),
                      decoration: BoxDecoration(
                        color: AppColors.appPrimary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    const IntroCard(),
                    Positioned(
                      top: 150,
                      right: 25.w,
                      left: 25.w,
                      bottom: 0,
                      child: const HomeCard(),
                    ),
                  ],
                ),
                const TasksAndStartAndEndWork(),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomBar(),
        );
      },
    );
  }
}
