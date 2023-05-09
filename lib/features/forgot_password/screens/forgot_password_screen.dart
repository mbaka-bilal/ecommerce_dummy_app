import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication_bloc.dart';
import '../../../bloc/authentication_state.dart';
import '../../../bloc/form_state_cubit.dart';
import '../../../models/authentication_model.dart';
import '../../../repositories/authentication_respository.dart';
import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/validator.dart';
import '../../../widgets/my_alert_dialog.dart';
import '../../../widgets/my_form.dart';
import '../../../widgets/mybutton.dart';
import 'email_sent_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double smallSpace = 10;
    const double mediumSpace = 20;
    final emailController = TextEditingController();
    final GlobalKey<FormState> forgotPasswordformKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<LoginFormStatus>().reset();
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.gray,
          ),
        ),
        title: Text(
          "Forgot Password",
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
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.authenticationModel.authenticationStatus) {
                  case AuthenticationStatus.resettingPasswordInProgress:
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
                  case AuthenticationStatus.resettingPasswordSuccessfully:
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetLinkSentScreen()));
                            },
                          );
                        });
                    break;
                  case AuthenticationStatus.resettingPasswordError:
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
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Form(
                      key: forgotPasswordformKey,
                      child: Column(
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
                            formKey: forgotPasswordformKey,
                            formFieldValidator: FormValidator.validateEmail,
                            textEditingController: emailController,
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                            // hint: Text("jessicamaria@infomail.com",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodySmall!
                            //         .copyWith(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: mediumSpace,
                    ),
                    BlocBuilder<LoginFormStatus, bool>(
                      builder: (context, state) => MyButton(
                        text: "Reset password 🤦",
                        height: 50,
                        width: double.infinity,
                        function: (state)
                            ? () async {
                                await RepositoryProvider.of<
                                        AuthenticationRepository>(context)
                                    .resetPassword(emailController.text.trim());
                              }
                            : null,
                        buttonColor: AppColors.blue,
                      ),
                    ),
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
