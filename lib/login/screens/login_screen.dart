import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/form_state_cubit.dart';
import '../../../signup/screens/signup.dart';
import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/validator.dart';
import '../../../widgets/my_form.dart';
import '../../../widgets/mybutton.dart';


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
                          hint: Text("jessicamaria@infomail.com",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey)),
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
                          keyboardType: TextInputType.name,
                          textEditingController: passwordController,
                          hint: Row(
                            children: List.generate(
                                10,
                                (index) => const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 5,
                                      ),
                                    )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot password",
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
                                    // print ("button pressed");
                                    // if (!_formKey.currentState!.validate()){
                                    //   print ("successfull");
                                    //   return;
                                    // }
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
                                function: () {},
                                leadingIcon: SvgPicture.asset(AppImages.google),
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
    );
  }
}