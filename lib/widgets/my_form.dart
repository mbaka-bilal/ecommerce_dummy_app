import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/form_state_cubit.dart';
import '../utils/appstyles.dart';

class MyFormField extends StatefulWidget {
  const MyFormField(
      {Key? key,
      required this.hint,
      this.trailingIcon,
      required this.isPassword,
      required this.textEditingController,
      required this.formFieldValidator,
        this.formKey, this.keyboardType,

        })
      : super(key: key);

  final Widget hint;
  final Widget? trailingIcon;
  final bool isPassword;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?> formFieldValidator;
  final GlobalKey<FormState>? formKey;
  final TextInputType? keyboardType;

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  final focusNode = FocusNode();
  bool showHint = true;
  bool hidePassword = true;
  bool showSuffixIcon = false;
  String? text;
  Widget? endIcon;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      // print ("listener activated");
      if (focusNode.hasFocus) {
        setState(() {
          showHint = false;
        });
      }

      if (!focusNode.hasFocus) {
        // print("does not have focus");
        if (text == null || text!.trim() == "") {
          setState(() {
            showHint = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          keyboardType: widget.keyboardType,
          validator: widget.formFieldValidator,
          focusNode: focusNode,
          controller: widget.textEditingController,
          obscureText: (widget.isPassword) ? hidePassword : false,
          onChanged: (str) {
            context.read<LoginFormStatus>().checkLoginFormStatus(widget.formKey!);
            if (str.trim() == "") {
              endIcon = null;
              text = null;
            } else {
              text = str;
              if (widget.formFieldValidator(str) == null) {
                setState(() {
                  showSuffixIcon = true;
                  endIcon = const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                  );
                });
                //update the email part of the form.

              } else {
                setState(() {
                  showSuffixIcon = false;
                  endIcon = const Icon(
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
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: (hidePassword)
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  : endIcon,
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
