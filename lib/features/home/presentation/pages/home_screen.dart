import 'dart:developer';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/end_work/end_work_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_counter.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/start_work/start_work_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
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
          appBar: AppBar(
            backgroundColor: AppColors.appPrimary,
            title: Text(
              tr('home_page'),
              style: AppTextStyles.bold18.copyWith(color: AppColors.white),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: AppTextStyles.regular12,
                        children: <InlineSpan>[
                          TextSpan(
                              text: '${tr('Welcome')} ! ',
                              style: AppTextStyles.bold16),
                          TextSpan(
                              text: 'fsdf',
                              style: AppTextStyles.bold16
                                  .copyWith(color: AppColors.appPrimary)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpacing(50),
                    Row(
                      children: [
                        Expanded(
                          child: BlocProvider<StartWorkCubit>(
                            create: (context) =>
                                StartWorkCubit(startWorkUseCase: sl()),
                            child: BlocConsumer<StartWorkCubit, StartWorkState>(
                              listener: (context, state) {
                                log(state.toString());
                                if (state is StartWorkFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.greyDark,
                                      content: Text(
                                        state.message,
                                        style: AppTextStyles.medium14
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  );
                                }
                                if (state is StartWorkSuccess) {
                                  WorkingHoursCounter.autoIncrement();
                                }
                              },
                              builder: (context, state) {
                                if (state is StartWorkLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.appPrimary),
                                  );
                                }
                                return AppTextButton(
                                  buttonText: tr('start_working'),
                                  onPressed: () {
                                    context.read<StartWorkCubit>().startWork();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        horizontalSpacing(20),
                        Expanded(
                          child: BlocProvider(
                            create: (context) =>
                                EndWorkCubit(endWorkUseCase: sl()),
                            child: BlocConsumer<EndWorkCubit, EndWorkState>(
                              listener: (context, state) {
                                log(state.toString());
                                if (state is EndWorkFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.greyDark,
                                      content: Text(
                                        state.message,
                                        style: AppTextStyles.medium14
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  );
                                }
                                if (state is EndWorkSuccess) {
                                  WorkingHoursCounter.stopTimer();
                                }
                              },
                              builder: (context, state) {
                                return AppTextButton(
                                  buttonText: tr('end_working'),
                                  onPressed: () {
                                    context.read<EndWorkCubit>().endWork();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(50),
                    Center(
                      child: BlocProvider(
                        create: (context) =>
                            sl<WorkingHoursCubit>()..getTotalWorkingHours(),
                        child:
                            BlocBuilder<WorkingHoursCubit, WorkingHoursState>(
                          builder: (context, state) {
                            return StreamBuilder(
                                stream: WorkingHoursCounter.stream,
                                initialData: WorkingHoursCounter.seconds,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return Text(
                                    'Working Hours: ${WorkingHoursCounter.hoursAndMinutesAndSeconds(snapshot.data!)}',
                                    style: AppTextStyles.bold16,
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    verticalSpacing(50),
                    Text(
                      '${tr('start_date')} :',
                      style: AppTextStyles.bold16,
                    ),
                    verticalSpacing(10),
                    Text(
                      '2022-01-01',
                      style: AppTextStyles.regular14,
                    ),
                    verticalSpacing(15),
                    Text(
                      '${tr('end_date')} :',
                      style: AppTextStyles.bold16,
                    ),
                    verticalSpacing(10),
                    Text(
                      '2022-01-01',
                      style: AppTextStyles.regular14,
                    ),
                    verticalSpacing(50),
                    BlocConsumer<SignOutCubit, SignOutState>(
                      listener: (context, state) {
                        if (state is SignOutError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SignOutLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.appPrimary,
                            ),
                          );
                        }
                        return AppTextButton(
                          buttonText: tr('sign_out'),
                          onPressed: () {
                            context.read<SignOutCubit>().signOut();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
