import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../bloc/authentication_bloc.dart';
import '../../../../bloc/authentication_state.dart';
import '../../../../bloc/form_state_cubit.dart';
import '../../../../models/authentication_model.dart';
import '../../../../repositories/authentication_respository.dart';
import '../../../../repositories/user_repository.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/appstyles.dart';
import '../../../../utils/validator.dart';
import '../../../../widgets/custom_form.dart';
import '../../../../widgets/my_alert_dialog.dart';
import '../../../../widgets/my_form.dart';
import '../../../../widgets/mybutton.dart';
import '../../../dashboard/screens/dashboard.dart';
import '../../../forgot_password/screens/forgot_password_screen.dart';
import '../../signup/screens/signup.dart';
import '../../signup/screens/signup_successfull.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double smallSpace = 10;
    const double mediumSpace = 20;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Widget socialButtons(
        {required Widget leadingIcon,
        required String socialName,
        required Function function}) {
      return InkWell(
        onTap: () => function(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              leadingIcon,
              const SizedBox(
                width: smallSpace,
              ),
              Text(
                socialName,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign in",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.gray,
              ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.authenticationModel.authenticationStatus) {
                    case AuthenticationStatus.loginInProgress:
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

                    case AuthenticationStatus.loginSuccessfully:
                      Navigator.of(context).pop();
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return MyAlertDialog(
                              enableBackButton: false,
                              widget: Image.asset(AppImages.successPng),
                              text: state.authenticationModel.statusMessage!,
                              function: () {
                                Navigator.of(context).pop();
                                RepositoryProvider.of<UserRepository>(context)
                                    .fetchUser();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DashBoard()),
                                    (route) => false);
                              },
                            );
                          });
                      break;
                    case AuthenticationStatus.emailNotVerified:
                      Navigator.of(context).pop();
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return MyAlertDialog(
                              enableBackButton: true,
                              widget: Image.asset(AppImages.errorPng),
                              text: state.authenticationModel.statusMessage!,
                              function: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpSuccessfullyScreen()));
                              },
                            );
                          });
                      break;

                    case AuthenticationStatus.loginError:
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: mediumSpace,
                          ),
                          MyFormField(
                            formKey: formKey,
                            formFieldValidator: FormValidator.validateEmail,
                            textEditingController: emailController,
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                            hint: "jessicamaria@infomail.com",
                          ),
                          const SizedBox(
                            height: mediumSpace,
                          ),
                          Text(
                            "Password",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: mediumSpace,
                          ),
                          MyFormField(
                            formKey: formKey,
                            formFieldValidator: FormValidator.validatePassword,
                            isPassword: true,
                            // expands: false,
                            // maxLines: null,
                            // minLines: null,
                            keyboardType: TextInputType.name,
                            textEditingController: passwordController,
                            hint: "*************",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    context.read<LoginFormStatus>().reset();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()));
                                  },
                                  child: Text(
                                    "Forgot password ?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.grey),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: mediumSpace,
                          ),
                          BlocBuilder<LoginFormStatus, bool>(
                            builder: (context, state) => MyButton(
                              text: "Sign in",
                              height: 50,
                              width: double.infinity,
                              function: (state)
                                  ? () {
                                      RepositoryProvider.of<
                                              AuthenticationRepository>(context)
                                          .signInEmailAndPassword(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
                                                  .trim());
                                    }
                                  : null,
                              buttonColor: AppColors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: mediumSpace,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: mediumSpace),
                                child: Text(
                                  "Or sign in with",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: mediumSpace,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              socialButtons(
                                  leadingIcon:
                                      SvgPicture.asset(AppImages.faceBook),
                                  socialName: "Facebook",
                                  function: () {}),
                              socialButtons(
                                  function: () async {
                                    await RepositoryProvider.of<
                                            AuthenticationRepository>(context)
                                        .signInWithGoogle();
                                  },
                                  leadingIcon:
                                      SvgPicture.asset(AppImages.google),
                                  socialName: "Google"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          width: smallSpace,
                        ),
                        InkWell(
                          onTap: () {
                            context.read<LoginFormStatus>().reset();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
