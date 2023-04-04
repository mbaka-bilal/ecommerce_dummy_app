import 'package:flutter/material.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

class ResetLinkSentScreen extends StatelessWidget {
  const ResetLinkSentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const bigSpace = 30.0;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          },
            icon: const Icon(Icons.arrow_back_ios,color: AppColors.gray,),
          ),
          // title: Text(
          //   "Sign Up",
          //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
          //     color: AppColors.gray,
          //   ),
          // ),
          // centerTitle: true,
        ),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppImages.mailPng),
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
            "To reset your password, \n"
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
            onPressed: () {},
            child: Text(
              "Resend Email",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14, color: AppColors.blue),
            ))
      ],
    ));
  }
}
