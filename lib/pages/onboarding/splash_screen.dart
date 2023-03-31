import 'package:ecommerce_dummy_app/pages/onboarding/onboarding_screen.dart';
import 'package:ecommerce_dummy_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/appstyles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    Future.delayed(
        const Duration(seconds: 5),
        () => nav.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
            (route) => false));

    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          SvgPicture.asset(
            AppImages.logo,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          SvgPicture.asset(AppImages.eshopLogo),
        ],
      ),
    );
  }
}
