import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    Key? key,
    required this.widget,
    required this.text,
    required this.enableBackButton
  }) : super(key: key);

  final Widget widget;
  final String text;

  final bool enableBackButton;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(enableBackButton),
      child: AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          widget,
          const SizedBox(
            height: 20,
          ),
          Text(text),
        ]),
      ),
    );
  }
}
