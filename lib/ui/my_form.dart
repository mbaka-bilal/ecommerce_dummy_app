import 'package:flutter/material.dart';

import '../utils/appstyles.dart';

class MyFormField extends StatefulWidget {
  const MyFormField({Key? key, required this.hint, this.trailingIcon})
      : super(key: key);

  final Widget hint;
  final Widget? trailingIcon;

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  FocusNode focusNode = FocusNode();
  bool showHint = true;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showHint = false;
        });
      } else {
        if (textController.text.trim().isEmpty) {
          showHint = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          focusNode: focusNode,
          controller: textController,
          decoration: InputDecoration(
              fillColor: AppColors.gray07,
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: widget.trailingIcon!,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12))),
        ),
        Positioned.fill(
          child: Visibility(
            visible: showHint,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: widget.hint,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}