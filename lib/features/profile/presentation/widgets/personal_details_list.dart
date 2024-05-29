import 'package:attendance_keeper/core/themes/app_colors.dart';
import 'package:attendance_keeper/core/widgets/app_spacer.dart';
import 'package:attendance_keeper/features/home/presentation/cubit/user_data/user_data_cubit.dart';
import 'package:attendance_keeper/features/profile/presentation/widgets/data_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDetailsList extends StatelessWidget {
  const PersonalDetailsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.appPrimary,
          ));
        }
        if (state is UserDataError) {
          return Text(state.message);
        }
        if (state is UserDataLoaded) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              DataItem(
                icon: Icons.person,
                headlineText: tr('name'),
                subtitleList: state.user!['name'],
              ),
              verticalSpacing(10),
              DataItem(
                icon: Icons.email,
                headlineText: tr('email'),
                subtitleList: state.user!['email'],
              ),
              verticalSpacing(10),
              DataItem(
                icon: Icons.email,
                headlineText: tr('job_title'),
                subtitleList: state.user!['jobTitle'],
              ),
            ],
          );
        }
        return const CircularProgressIndicator(color: AppColors.appPrimary);
      },
    );
  }
}
