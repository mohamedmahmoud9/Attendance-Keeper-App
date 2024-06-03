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
    return Column(
      children: [
        ...List.generate(
          endWorkCubit.tasks.length,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 8.sp),
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(12.r)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    endWorkCubit.tasks[index],
                    style: AppTextStyles.regular14,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                  onPressed: () {
                    endWorkCubit.removeTask(index);
                  },
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                enabled: isStarted,
                selectionHeightStyle: BoxHeightStyle.tight,
                keyboardType: TextInputType.text,
                controller: endWorkCubit.tasksController,
                cursorColor: AppColors.appPrimary,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => endWorkCubit.addTask(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(
                      color: AppColors.appPrimary,
                    ),
                  ),
                  hintText: tr('enter_today_tasks'),
                  hintStyle: AppTextStyles.regular14
                      .copyWith(color: AppColors.appPrimary),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                endWorkCubit.addTask();
                // endWorkCubit.tasksController.clear();
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(shape: const StadiumBorder()),
              color: AppColors.appPrimary,
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.delete),
            //   color: AppColors.appPrimary,
            // ),
          ],
        ),
      ],
    );
  }
}
