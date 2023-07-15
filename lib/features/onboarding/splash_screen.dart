import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/authentication_bloc.dart';
import '../../bloc/authentication_state.dart';
import '../../models/authentication_model.dart';
import '../../repositories/authentication_respository.dart';
import '../../repositories/database_repository.dart';
import '../../repositories/user_repository.dart';
import '../dashboard/screens/dashboard.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

import 'onboarding_screen.dart';

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

    RepositoryProvider.of<AuthenticationRepository>(context).tryGetUser();
    if (FirebaseAuth.instance.currentUser != null) {
      RepositoryProvider.of<DatabaseRepository>(context)
          .favoriteProducts(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authenticationBloc = context.read<AuthenticationBloc>();

    return Scaffold(
      backgroundColor: AppColors.blue,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authenticationModel.authenticationStatus) {
            case AuthenticationStatus.authenticated:
              RepositoryProvider.of<UserRepository>(context).fetchUser();
              nextScreen(const DashBoard());
              break;
            case AuthenticationStatus.unauthenticated:
              nextScreen(const OnBoardingScreen());
              break;
            case AuthenticationStatus.unKnown:
              nextScreen(const OnBoardingScreen());
              break;
            default:
              nextScreen(const OnBoardingScreen());
              break;
          }
        },
        child: Column(
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
