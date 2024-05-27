import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/user_data/user_data_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${tr('Welcome')} ! ',
                  style: AppTextStyles.bold22.copyWith(
                    color: AppColors.white,
                  ),
                ),
                BlocProvider(
                  create: (context) => sl<UserDataCubit>()..getUserData(),
                  child: BlocBuilder<UserDataCubit, UserDataState>(
                    builder: (context, state) {
                      if (state is UserDataLoading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.white,
                        ));
                      }
                      if (state is UserDataError) {
                        return Text(state.message);
                      }
                      if (state is UserDataLoaded) {
                        return Text(
                          '${state.user?['name']} ',
                          style: AppTextStyles.bold22.copyWith(
                            color: AppColors.white,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                horizontalSpacing(5),
                const Icon(Icons.waving_hand_outlined, color: AppColors.white),
              ],
            ),
            verticalSpacing(5),
            Text(
              tr('lets_start_working_and_wish_you_a_good_day'),
              style: AppTextStyles.regular12.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
