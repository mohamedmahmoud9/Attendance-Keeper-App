import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/navigation_bar/navigation_bar_cubit.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocConsumer<SignOutCubit, SignOutState>(
        listener: (context, state) {
          if (state is SignOutError) {
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
          if (state is SignOutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.greyDark,
                content: Text(
                  tr('sign_out_success'),
                  style:
                      AppTextStyles.medium14.copyWith(color: AppColors.white),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SignOutLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.appPrimary),
            );
          }
          return AppTextButton(
            buttonText: tr('sign_out'),
            onPressed: () {
              sl<SignOutCubit>().signOut();
              sl<NavigationBarCubit>().updateIndex(0);
            },
          );
        },
      ),
    );
  }
}
