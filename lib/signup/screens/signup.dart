import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/form_state_cubit.dart';
import '../../../widgets/my_form.dart';
import '../../../widgets/mybutton.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/validator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double smallSpace = 10;
    const double mediumSpace = 20;
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios,color: AppColors.gray,),
        ),
        title: Text(
          "Sign Up",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.gray,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context,constraints) => SingleChildScrollView(
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
                    key: signUpFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: mediumSpace,
                        ),
                        MyFormField(
                          formKey: signUpFormKey,
                          formFieldValidator: FormValidator.validateName,
                          textEditingController: firstNameController,
                          keyboardType: TextInputType.emailAddress,
                          isPassword: false,
                          hint: Text("jessica",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: mediumSpace,
                        ),
                        Text(
                          "Last Name",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: mediumSpace,
                        ),
                        MyFormField(
                          formKey: signUpFormKey,
                          formFieldValidator: FormValidator.validateName,
                          textEditingController: lastNameController,
                          keyboardType: TextInputType.emailAddress,
                          isPassword: false,
                          hint: Text("Maria",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: mediumSpace,
                        ),
                        Text(
                          "Email",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: mediumSpace,
                        ),
                        MyFormField(
                          formKey: signUpFormKey,
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
                          formKey: signUpFormKey,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: mediumSpace,
                  ),
                  BlocBuilder<LoginFormStatus, bool>(
                    builder: (context, state) => MyButton(
                      text: "Sign Up",
                      height: 50,
                      width: double.infinity,
                      function: (state)
                          ? () {

                      }
                          : null,
                      buttonColor: AppColors.blue,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have an account?",
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
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Sign In",
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