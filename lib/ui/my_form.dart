import 'package:flutter/material.dart';

import '../utils/appstyles.dart';

class MyFormField extends StatefulWidget {
  const MyFormField(
      {Key? key,
      required this.hint,
      this.trailingIcon,
      required this.isPassword,
      required this.textEditingController, required this.formFieldValidator})
      : super(key: key);

  final Widget hint;
  final Widget? trailingIcon;
  final bool isPassword;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?> formFieldValidator;

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  final focusNode = FocusNode();
  bool showHint = true;
  bool showPassword = false;
  bool showSuffixIcon = false;

  Widget? endIcon;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showHint = false;
        });
      } else {
        if (widget.textEditingController.text.trim().isEmpty) {
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
          controller: widget.textEditingController,
          obscureText: showPassword,
          onChanged: (str) {
            if (str.trim() == ""){
              endIcon = null;
            }else{
              if (widget.formFieldValidator(str) == null){
                setState(() {
                  showSuffixIcon = true;
                  endIcon = const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                  );
                });
              }else{
                setState(() {
                  showSuffixIcon = false;
                  endIcon =Icon(
                    Icons.close,
                    color: Colors.red,
                  );
                });
              }
            }

          },
          decoration: InputDecoration(
              fillColor: AppColors.gray07,
              filled: true,
              suffixIcon: (widget.isPassword)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: (showPassword)
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  :  endIcon,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12))),
        ),
        Positioned.fill(
          child: Visibility(
            visible: showHint,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (focusNode.hasFocus) {
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
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
