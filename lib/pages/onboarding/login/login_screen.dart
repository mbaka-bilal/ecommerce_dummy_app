
import 'package:ecommerce_dummy_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../ui/my_form.dart';
import '../../../ui/mybutton.dart';

import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double smallSpace = 10;
    const double mediumSpace = 20;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Widget socialButtons(
        {required Widget leadingIcon, required String socialName,required Function function}) {
      return InkWell(
        onTap: () => function(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                  Column(
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
                        formFieldValidator: FormValidator.validateEmail,
                        textEditingController: emailController,
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
                        formFieldValidator: FormValidator.validatePassword,
                        isPassword: true,
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
                      MyButton(
                        text: "Sign in",
                        height: 50,
                        width: double.infinity,
                        function: () {},
                        buttonColor: AppColors.blue,
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
                            padding: const EdgeInsets.symmetric(horizontal: mediumSpace),
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
                              leadingIcon: SvgPicture.asset(AppImages.faceBook),
                              socialName: "Facebook",
                              function: () {}
                          ),
                          socialButtons(
                              function: () {},
                              leadingIcon: SvgPicture.asset(AppImages.google),
                              socialName: "Google"),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey
                      ),),
                      const SizedBox(
                        width: smallSpace,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("Sign Up",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.blue
                        ),),
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


