import 'package:flutter/material.dart';
import 'package:stroll_task/common/routes/routes.dart';
import 'package:stroll_task/core/navigation/navigation_handler.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      NavigationHandler().replace(context, Routes.profileOnBoardingScreen);
    });

    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Launching Stroll Social... Please Wait...',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
