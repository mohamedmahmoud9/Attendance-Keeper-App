import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/widgets/app_text_button.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/sign_out/sign_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: BlocConsumer<SignOutCubit, SignOutState>(
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
                  buttonText: 'Sign Out',
                  onPressed: () {
                    context.read<SignOutCubit>().signOut();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
