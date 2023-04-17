import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';
import '../../widgets/circular_progress.dart';
import '../../widgets/mybutton.dart';

import 'login/screens/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Timer? timer;
  int index = 0;
  PageController pageController = PageController();
  final headerTexts = <String>[
    "Biggest Sell at Your Fingerprint",
    "Pay Secure Payment Gateway",
    "Get Faster and Safe Delivery"
  ];
  final images = <String>[
    AppImages.firstOnBoardingImage,
    AppImages.secondOnBoardingImage,
    AppImages.thirdOnBoardingImage,
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          if (pageController.page!.round() + 1 > 2) {
            index = 0;
          } else {
            index = pageController.page!.round() + 1;
          }
        });
      }

      if (index > 2) {
        pageController.animateToPage(0,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
      } else {
        pageController.animateToPage(index,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              children: [],
            ),
          ),
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) => PageContent(
                  imagePath: images[index], headingText: headerTexts[index]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        // timer ?? timer!.cancel();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      child: Text(
                        "Skip",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey),
                      )),
                  CircleProgress(index: index, range: 3),
                  MyButton(
                    function: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                    text: "Next",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                    buttonColor: AppColors.blue,
                    height: 36,
                    width: 100,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({
    Key? key,
    required this.imagePath,
    required this.headingText,
  }) : super(key: key);

  final String imagePath;
  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.fitWidth,
            )),
        SizedBox(
            width: 200,
            child: Text(
              headingText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 300,
            child: Text(
              "Find your best products from popular shop without any delay",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ))
      ],
    );
  }
}
