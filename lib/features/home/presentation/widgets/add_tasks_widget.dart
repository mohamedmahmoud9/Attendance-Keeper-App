import 'dart:ui';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/end_work/end_work_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTasksWidget extends StatelessWidget {
  final EndWorkCubit endWorkCubit;
  final bool isStarted;
  const AddTasksWidget({
    super.key,
    required this.endWorkCubit,
    required this.isStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            selectionHeightStyle: BoxHeightStyle.tight,
            keyboardType: TextInputType.text,
            controller: endWorkCubit.tasksController,
            cursorColor: AppColors.appPrimary,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppColors.appPrimary,
                ),
              ),
              hintText: tr('enter_today_tasks'),
              hintStyle:
                  AppTextStyles.regular14.copyWith(color: AppColors.appPrimary),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            endWorkCubit.addTask(endWorkCubit.tasksController.text);
            endWorkCubit.tasksController.clear();
          },
          icon: const Icon(Icons.add),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          color: AppColors.appPrimary,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete),
          color: AppColors.appPrimary,
        ),
      ],
    );
  }
}
