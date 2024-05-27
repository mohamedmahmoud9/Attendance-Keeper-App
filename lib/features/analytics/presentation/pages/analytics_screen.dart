import 'package:attendance_keeper/core/widgets/app_bottom_bar.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Analytics Screen'),
      ),
      bottomNavigationBar: AppBottomBar(),
    );
  }
}
