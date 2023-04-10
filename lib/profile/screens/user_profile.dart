import 'package:ecommerce_dummy_app/login/screens/login_screen.dart';
import 'package:ecommerce_dummy_app/utils/appstyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../repositories/authentication_respository.dart';
import '../../utils/app_images.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double smallSpace = 20;
    const double bigSpace = 50;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              ClipOval(
                child: Image.asset(
                  AppImages.defaultProfilePicPng,
                  scale: 0.5,
                ),
              ),
              const SizedBox(
                height: smallSpace,
              ),
              Text(
                "Jessica Maria",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("jessica_maria68@example.com",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 14, color: AppColors.gray03)),
              const SizedBox(
                height: bigSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Payment Methods",
                  icon: Icons.wallet),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Account Information",
                  icon: Icons.person),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Notifications",
                  icon: Icons.notifications),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Invite Friends",
                  icon: Icons.people),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Security",
                  icon: Icons.lock),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Settings",
                  icon: Icons.settings),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: Placeholder(),
                  title: "Terms of services",
                  icon: Icons.local_post_office),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(toPage: LoginScreen(),
                  title: "Sign Out",
                  icon: Icons.logout_rounded),
              const SizedBox(
                height: smallSpace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RowOption extends StatelessWidget {
  const RowOption({Key? key, required this.toPage, required this.title, required this.icon}) : super(key: key);

  final Widget toPage;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final nav =  Navigator.of(context);
    return InkWell(
      onTap: () async {
        if (title == "Sign Out") {
          await RepositoryProvider.of<
            AuthenticationRepository>(context).logOut();
          nav.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => toPage), (route) => false);
        }else{
          nav.push(MaterialPageRoute(builder: (context) => toPage));
        }

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.gray07,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(icon,color: AppColors.gray03,)),
              const SizedBox(
                width: 10,
              ),
              Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 14,
              ),)
            ],
          ),
          const Icon(Icons.arrow_forward_ios,color: AppColors.gray03,)
        ],
      ),
    );
  }
}

