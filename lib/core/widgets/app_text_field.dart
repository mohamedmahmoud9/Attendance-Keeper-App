import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final Widget? prefixIcon;
  final bool? obscureText;

  const AppTextField(
      {super.key,
      this.controller,
      this.keyboardType,
      this.labelText,
      this.prefixIcon,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.greyDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.appPrimary,
          ),
        ),
        labelText: labelText,
        labelStyle: AppTextStyles.semiBold12.copyWith(color: AppColors.black),
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText ?? false,
      obscuringCharacter: '•',
    );
  }
}
