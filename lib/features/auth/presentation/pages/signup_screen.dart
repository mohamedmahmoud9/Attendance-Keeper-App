import 'package:attendance_keeper/core/routers/routes.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_navigator.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/core/widgets/app_text_field.dart';
import 'package:attendance_keeper/features/auth/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => sl<SignUpCubit>(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (BuildContext context, state) {
          final SignUpCubit signUpCubit = context.read<SignUpCubit>();
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                    child: Form(
                      key: signUpCubit.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(tr('sign_up'), style: AppTextStyles.bold20),
                          verticalSpacing(15),
                          Text(tr('please_enter_sign_up_details'),
                              style: AppTextStyles.regular12),
                          verticalSpacing(30),
                          AppTextField(
                            controller: signUpCubit.nameController,
                            labelText: tr('name'),
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          verticalSpacing(15),
                          AppTextField(
                            controller: signUpCubit.jobTitleController,
                            labelText: tr('job_title'),
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(Icons.work),
                          ),
                          verticalSpacing(15),
                          AppTextField(
                            controller: signUpCubit.emailController,
                            labelText: tr('email'),
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email),
                          ),
                          verticalSpacing(15),
                          AppTextField(
                            controller: signUpCubit.passwordController,
                            labelText: tr('password'),
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: IconButton(
                              icon: _obscureText1
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _obscureText1 = !_obscureText1;
                                });
                              },
                            ),
                            obscureText: _obscureText1,
                          ),
                          verticalSpacing(15),
                          AppTextField(
                            controller: signUpCubit.confirmPasswordController,
                            labelText: tr('comfirm_password'),
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: IconButton(
                              icon: _obscureText2
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                            obscureText: _obscureText2,
                          ),
                          verticalSpacing(30),
                          BlocConsumer<SignUpCubit, SignUpState>(
                            listener: (context, state) {
                              if (state is SignUpSuccess) {
                                context.pushReplacementNamed(Routes.homeScreen);
                              }
                              if (state is SignUpError) {
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
                            },
                            builder: (context, state) {
                              if (state is SignUpLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.appPrimary,
                                  ),
                                );
                              }
                              return AppTextButton(
                                onPressed: () {
                                  context.read<SignUpCubit>().signUp();
                                },
                                buttonText: tr('sign_up'),
                              );
                            },
                          ),
                          verticalSpacing(30),
                          InkWell(
                            onTap: () => context
                                .pushReplacementNamed(Routes.signInScreen),
                            child: Text.rich(
                              TextSpan(
                                style: AppTextStyles.regular12,
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: tr('do_you_have_an_account'),
                                  ),
                                  TextSpan(
                                      text: ' ${tr('sign_in')}',
                                      style: AppTextStyles.bold12.copyWith(
                                          color: AppColors.appPrimary)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
