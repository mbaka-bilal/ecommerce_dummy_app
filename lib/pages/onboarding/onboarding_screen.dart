import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [],
          ),
          Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    AppImages.firstOnBoardingImage,
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 150,
                  child: Text(
                    "Biggest sale at your Fingertip",
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 250,
                  child: Text(
                    "Find your best products from popular shop without any delay",
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text("Skip")),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.blue,
                      radius: 5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 5,
                    )
                  ],
                ),
                MyButton(
                  text: "Next",
                  buttonColor: AppColors.blue,
                  height: 36,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      this.function,
      required this.text,
      this.textStyle,
      this.buttonColor,
      this.width,
      this.height})
      : super(key: key);
  final Function? function;
  final String text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          function;
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(buttonColor ?? buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ))),
        child: Text(
          text,
          style: (textStyle == null)
              ? const TextStyle(
                  color: Colors.white,
                )
              : textStyle,
        ),
      ),
    );
  }
}
