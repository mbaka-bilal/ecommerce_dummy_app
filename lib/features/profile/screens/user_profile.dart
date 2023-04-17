import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication_bloc.dart';
import '../../../bloc/user_info_bloc.dart';
import '../../../bloc/user_info_state.dart';
import '../../../repositories/authentication_respository.dart';
import '../../../repositories/user_repository.dart';
import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';
import '../../onboarding/login/screens/login_screen.dart';


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
              BlocBuilder<UserInfoBloc, UserInfoState>(
                // bloc: UserInfoBloc(),
                builder: (context, state) => Column(
                  children: [
                    Text(
                      "${(state.user.firstName.isNotEmpty) ? state.user.firstName.replaceRange(0, 1, state.user.firstName[0].toUpperCase()) : ""} "
                      "${(state.user.firstName.isNotEmpty) ? state.user.lastName.replaceRange(0, 1, state.user.lastName[0].toUpperCase()) : ""}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(state.user.email,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 14, color: AppColors.gray03)),
                    const SizedBox(
                      height: bigSpace,
                    ),
                  ],
                ),
              ),
              const RowOption(
                  toPage: Placeholder(),
                  title: "Payment Methods",
                  icon: Icons.wallet),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: Placeholder(),
                  title: "Account Information",
                  icon: Icons.person),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: Placeholder(),
                  title: "Notifications",
                  icon: Icons.notifications),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: Placeholder(),
                  title: "Invite Friends",
                  icon: Icons.people),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: Placeholder(), title: "Security", icon: Icons.lock),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: Placeholder(),
                  title: "Settings",
                  icon: Icons.settings),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: Placeholder(),
                  title: "Terms of services",
                  icon: Icons.local_post_office),
              const SizedBox(
                height: smallSpace,
              ),
              const RowOption(
                  toPage: LoginScreen(),
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
  const RowOption(
      {Key? key, required this.toPage, required this.title, required this.icon})
      : super(key: key);

  final Widget toPage;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final authBloc = context.read<AuthenticationBloc>();
    final userBloc = context.read<UserInfoBloc>();
    final authRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final userRepository = RepositoryProvider.of<UserRepository>(context);

    return InkWell(
      onTap: () async {
        if (title == "Sign Out") {
          await authBloc.close();
          await userBloc.close();
          await authRepository.logOut();
          authRepository.dispose();
          userRepository.dispose();
          nav.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => toPage),
              (route) => false);
        } else {
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
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    icon,
                    color: AppColors.gray03,
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                    ),
              )
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.gray03,
          )
        ],
      ),
    );
  }
}
