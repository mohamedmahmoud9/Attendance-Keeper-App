import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                          child: AppTextButton(
                            buttonText: tr('start_working'),
                            onPressed: () {},
                          ),
                        ),
                        horizontalSpacing(20),
                        Expanded(
                          child: AppTextButton(
                            buttonText: tr('end_working'),
                            onPressed: () {},
                          ),
                        ),
                      ],
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
