import 'package:ecommerce_dummy_app/forgot_password/screens/email_sent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/form_state_cubit.dart';
import '../../utils/appstyles.dart';
import '../../utils/validator.dart';
import '../../widgets/my_form.dart';
import '../../widgets/mybutton.dart';

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
        leading: IconButton(onPressed: () {
          context.read<LoginFormStatus>().reset();
          Navigator.of(context).pop();
        },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.gray,),
        ),
        title: Text(
          "Forgot Password",
          style: Theme
              .of(context)
              .textTheme
              .titleMedium!
              .copyWith(
            color: AppColors.gray,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) =>
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,

                ),
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
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
                              hint: Text("jessicamaria@infomail.com",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: mediumSpace,
                      ),
                      BlocBuilder<LoginFormStatus, bool>(
                        builder: (context, state) =>
                            MyButton(
                              text: "Sign Up",
                              height: 50,
                              width: double.infinity,
                              function: (state)
                                  ? () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (
                                        context) => const ResetLinkSentScreen())
                                );
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
    );
  }
}
