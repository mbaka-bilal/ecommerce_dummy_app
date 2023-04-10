import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';
import '../models/authentication_model.dart';
import '../profile/screens/user_profile.dart';
import '../repositories/authentication_respository.dart';

import '../../onboarding/onboarding_screen.dart';
import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';



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
    // context.read<AuthenticationBloc>().add(AuthenticationStatusChanged(
    //     AuthenticationModel(authenticationStatus: AuthenticationStatus.authenticated)));
    // nextScreen(OnBoardingScreen());

    RepositoryProvider.of<
        AuthenticationRepository>(context).tryGetUser();
  }

  @override
  Widget build(BuildContext context) {
    // final authenticationBloc = context.read<AuthenticationBloc>();

    return Scaffold(
      backgroundColor: AppColors.blue,
      body:
      BlocListener<AuthenticationBloc, AuthenticationState>(
        // bloc: authenticationBloc,
        listener: (context, state) {
          // print("listening on spash page");
          switch (state.authenticationModel.authenticationStatus) {
            case AuthenticationStatus.authenticated:
              // print("you are authenticated");
              nextScreen(const UserProfile());
              // return;
              break;
            case AuthenticationStatus.unauthenticated:
              // print("you are not authenticated");
              nextScreen(const OnBoardingScreen());
              // return;
              break;
            case AuthenticationStatus.unKnown:
              // print("you are not authenticated state unknown");
              nextScreen(const OnBoardingScreen());
              // return;
              break;
          }
        },
        child:
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
      ),
    );
  }
}
