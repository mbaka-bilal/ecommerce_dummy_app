import 'package:ecommerce_dummy_app/bloc/authentication_bloc.dart';
import 'package:ecommerce_dummy_app/bloc/authentication_event.dart';
import 'package:ecommerce_dummy_app/repositories/authentication_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../onboarding/onboarding_screen.dart';
import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';
import '../bloc/authentication_state.dart';
import '../models/authentication_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextScreen(Widget page) async {
    final nav = Navigator.of(context);
    await Future.delayed(
        const Duration(seconds: 5),
        () => nav.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => page), (route) => false));
  }

  @override
  void initState() {
    super.initState();
    // context.read<AuthenticationBloc>().add(const AuthenticationStatusChanged(
    //     AuthenticationModel(authenticationStatus: AuthenticationStatus.unauthenticated)));
    nextScreen(OnBoardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    // final authenticationBloc = context.read<AuthenticationBloc>();

    return Scaffold(
      backgroundColor: AppColors.blue,
      body:
      // BlocListener<AuthenticationBloc, AuthenticationState>(
      //   // bloc: authenticationBloc,
      //   listener: (context, state) {
      //     print("listening on spash page");
      //     switch (state.status) {
      //       case AuthenticationStatus.authenticated:
      //         // print("you are authenticated");
      //         nextScreen(Placeholder());
      //         // return;
      //         break;
      //       case AuthenticationStatus.unauthenticated:
      //         // print("you are not authenticated");
      //         nextScreen(OnBoardingScreen());
      //         // return;
      //         break;
      //       case AuthenticationStatus.unKnown:
      //         // print("you are not authenticated state unknown");
      //         nextScreen(OnBoardingScreen());
      //         // return;
      //         break;
      //     }
      //   },
      //   child:
        Column(
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
      // ),
    );
  }
}
