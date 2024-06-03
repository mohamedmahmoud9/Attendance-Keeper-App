import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlotsCard extends StatelessWidget {
  final Timestamp start;
  final Timestamp? end;
  final List<String> tasks;

  const SlotsCard(
      {super.key, required this.start, required this.end, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${tr('from')} :',
                      style: AppTextStyles.semiBold14
                          .copyWith(color: AppColors.appPrimary),
                    ),
                    horizontalSpacing(5),
                    Text(
                      DateFormat('hh:mm a', 'ar').format(start.toDate()),
                      style: AppTextStyles.bold14
                          .copyWith(color: AppColors.greyDark),
                    ),
                  ],
                ),
                verticalSpacing(5),
                Row(
                  children: [
                    Text(
                      '${tr('to')} :',
                      style: AppTextStyles.semiBold14
                          .copyWith(color: AppColors.appPrimary),
                    ),
                    horizontalSpacing(5),
                    Text(
                      end == null
                          ? tr('until_now')
                          : DateFormat('hh:mm a', 'ar').format(end!.toDate()),
                      style: AppTextStyles.bold14
                          .copyWith(color: AppColors.greyDark),
                    ),
                  ],
                ),
                verticalSpacing(5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr('slot_tasks')} :',
                      style: AppTextStyles.semiBold14
                          .copyWith(color: AppColors.appPrimary),
                    ),
                    ...tasks.map(
                      (e) => Text(e),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
