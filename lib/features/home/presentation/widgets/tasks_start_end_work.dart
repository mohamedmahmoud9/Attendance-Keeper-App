import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/end_work/end_work_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/working_hours/working_hours_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/widgets/start_and_end_buttons.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasksAndStartAndEndWork extends StatefulWidget {
  const TasksAndStartAndEndWork({
    super.key,
  });

  @override
  State<TasksAndStartAndEndWork> createState() =>
      _TasksAndStartAndEndWorkState();
}

class _TasksAndStartAndEndWorkState extends State<TasksAndStartAndEndWork> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EndWorkCubit>(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.task_alt_rounded,
                    color: AppColors.appPrimary, size: 20.sp),
                horizontalSpacing(5),
                Text(tr('مهام اليوم'), style: AppTextStyles.bold14),
              ],
            ),
            verticalSpacing(7),
            BlocSelector<WorkingHoursCubit, WorkingHoursState, bool>(
              selector: (state) => state.isStartWork,
              builder: (context, isStarted) {
                return BlocBuilder<EndWorkCubit, EndWorkState>(
                  builder: (context, state) {
                    final endWorkCubit = BlocProvider.of<EndWorkCubit>(context);
                    return Form(
                      key: endWorkCubit.formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: endWorkCubit.tasksController,
                        readOnly: !isStarted,
                        maxLines: 5,
                        cursorColor: AppColors.appPrimary,
                        decoration: InputDecoration(
                          hintText: isStarted
                              ? tr('enter_today_tasks')
                              : tr('must_start_to_add_tasks'),
                          hintStyle: isStarted
                              ? AppTextStyles.regular14
                              : AppTextStyles.regular14
                                  .copyWith(color: Colors.red),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            borderSide: BorderSide(
                              width: 1.w,
                              color: Colors.red,
                            ),
                          ),
                          enabledBorder: isStarted
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: AppColors.greyDark,
                                  ),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                ),
                          focusedBorder: isStarted
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: AppColors.appPrimary,
                                  ),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: Colors.red,
                                  ),
                                ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            verticalSpacing(50),
            BlocSelector<WorkingHoursCubit, WorkingHoursState, bool>(
                selector: (state) => state.isStartWork,
                builder: (context, isStarted) {
                  if (isStarted) {
                    return const EndButton();
                  } else {
                    return const StartButton();
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sl<EndWorkCubit>().controllerDispose();
  }
}
