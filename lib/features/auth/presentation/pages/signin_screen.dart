import 'package:attendance_keeper/core/routers/routes.dart';
import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:attendance_keeper/core/widgets/app_navigator.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/core/widgets/app_text_field.dart';
import 'package:attendance_keeper/features/auth/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (BuildContext context, state) {
        final SignInCubit signinCubit = context.read<SignInCubit>();
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: Form(
                    key: signinCubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(tr('sign_in'), style: AppTextStyles.bold20),
                        verticalSpacing(15),
                        Text(tr('please_enter_sign_in_details'),
                            style: AppTextStyles.regular12),
                        verticalSpacing(30),
                        AppTextField(
                          controller: signinCubit.emailController,
                          labelText: tr('email'),
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email),
                        ),
                        verticalSpacing(15),
                        AppTextField(
                          controller: signinCubit.passwordController,
                          labelText: tr('password'),
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: IconButton(
                            icon: _obscureText
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          obscureText: _obscureText,
                        ),
                        verticalSpacing(30),
                        BlocConsumer<SignInCubit, SignInState>(
                          listener: (context, state) {
                            if (state is SignInError) {
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
                            if (state is SignInLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.appPrimary,
                                ),
                              );
                            }
                            return AppTextButton(
                              onPressed: () {
                                context.read<SignInCubit>().signIn();
                              },
                              buttonText: tr('sign_in'),
                            );
                          },
                        ),
                        verticalSpacing(30),
                        InkWell(
                          onTap: () => context.pushNamed(Routes.signUpScreen),
                          child: Text.rich(
                            TextSpan(
                              style: AppTextStyles.regular12,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: tr('dont_have_account'),
                                ),
                                TextSpan(
                                    text: ' ${tr('sign_up')}',
                                    style: AppTextStyles.bold12
                                        .copyWith(color: AppColors.appPrimary)),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    sl<SignInCubit>().clearControllers();
  }
}
