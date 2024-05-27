import 'dart:developer';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/end_work/end_work_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/start_work/start_work_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_counter.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EndButton extends StatelessWidget {
  const EndButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EndWorkCubit, EndWorkState>(
      listener: (context, state) {
        log(state.toString());
        if (state is EndWorkFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.greyDark,
              content: Text(
                state.message,
                style: AppTextStyles.medium14.copyWith(color: AppColors.white),
              ),
            ),
          );
        }
        if (state is EndWorkSuccess) {
          WorkingHoursCounter.stopTimer();
          
        }
      },
      builder: (context, state) {
        if (state is EndWorkLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.appPrimary),
          );
        }
        return AppTextButton(
          buttonText: tr('end_working'),
          onPressed: () {
            context.read<EndWorkCubit>().endWork();
          },
        );
      },
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartWorkCubit>(
      create: (context) => StartWorkCubit(startWorkUseCase: sl()),
      child: BlocConsumer<StartWorkCubit, StartWorkState>(
        listener: (context, state) {
          log(state.toString());
          if (state is StartWorkFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.greyDark,
                content: Text(
                  state.message,
                  style:
                      AppTextStyles.medium14.copyWith(color: AppColors.white),
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
              child: CircularProgressIndicator(color: AppColors.appPrimary),
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
    );
  }
}
