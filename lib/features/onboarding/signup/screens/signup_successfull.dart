import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/authentication_bloc.dart';
import '../../../../bloc/authentication_state.dart';
import '../../../../models/authentication_model.dart';
import '../../../../repositories/authentication_respository.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/appstyles.dart';
import '../../../../widgets/my_alert_dialog.dart';


class SignUpSuccessfullyScreen extends StatefulWidget {
  const SignUpSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  State<SignUpSuccessfullyScreen> createState() =>
      _SignUpSuccessfullyScreenState();
}

class _SignUpSuccessfullyScreenState extends State<SignUpSuccessfullyScreen> {
  late final AuthenticationRepository _repositoryProvider;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _repositoryProvider =
        RepositoryProvider.of<AuthenticationRepository>(context);
    _repositoryProvider.sendUserConfirmationLinkToEmail(user!);
  }

  @override
  Widget build(BuildContext context) {
    // const bigSpace = 30.0;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              print("go back");
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.gray,
            ),
          ),
          title: Text(
            "Sign Up",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.gray,
                ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.authenticationModel.authenticationStatus) {
              case AuthenticationStatus.sendingUserConfirmationLink:
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                          enableBackButton: false,
                          widget: const CircularProgressIndicator(),
                          text: state.authenticationModel.statusMessage!);
                    });
                break;
              case AuthenticationStatus.userConfirmationLinkSent:
                Navigator.of(context).pop();
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                        enableBackButton: true,
                        widget: Image.asset(AppImages.successPng),
                        text: "",
                        function: () => Navigator.of(context).pop(),
                      );
                    });

                break;
              case AuthenticationStatus.errorSendingUserConfirmationLink:
                Navigator.of(context).pop();
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                          enableBackButton: true,
                          widget: Image.asset(AppImages.errorPng),
                          text: state.authenticationModel.statusMessage!);
                    });
                break;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.ghuxtPng),
              const Row(
                children: [],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Check Your Email",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "To confirm your email address, \n"
                  "please click on the link in the \n"
                  "email we sent you",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.gray03),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    await _repositoryProvider
                        .sendUserConfirmationLinkToEmail(user!);
                  },
                  child: Text(
                    "Resend Email",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14, color: AppColors.blue),
                  ))
            ],
          ),
        ));
  }
}
