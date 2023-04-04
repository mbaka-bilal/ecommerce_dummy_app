import 'package:flutter/material.dart';

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
        onPressed: (function == null)
            ? null
            : () {
                function!();
              },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              } else {
                return buttonColor ?? buttonColor;
              }
            }),
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
