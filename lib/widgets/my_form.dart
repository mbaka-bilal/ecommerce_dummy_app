import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/form_state_cubit.dart';
import '../utils/appstyles.dart';

class MyFormField extends StatefulWidget {
  const MyFormField({
    Key? key,
    this.hint,
    this.trailingIcon,
    required this.isPassword,
    required this.textEditingController,
    required this.formFieldValidator,
    this.formKey,
    // this.maxLines,
    // this.minLines,
    // this.expands = false,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  final String? hint;
  final Widget? trailingIcon;
  final bool isPassword;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?> formFieldValidator;
  final GlobalKey<FormState>? formKey;
  final TextInputType? keyboardType;
  // final bool expands;
  // final int? maxLines;
  // final int? minLines;
  final ValueChanged<String?>? onChanged;

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
  // bool errorShown = false;

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
          textAlignVertical: TextAlignVertical.top,
          // expands: widget.expands,
          // maxLines: (widget.expands) ? null : widget.maxLines,
          // minLines: (widget.expands) ? null : widget.minLines,
          keyboardType: widget.keyboardType,
          validator: widget.formFieldValidator,
          focusNode: focusNode,

          controller: widget.textEditingController,
          obscureText: (widget.isPassword) ? hidePassword : false,
          onChanged: widget.onChanged ??
              (str) {
                context
                    .read<LoginFormStatus>()
                    .checkLoginFormStatus(widget.formKey!);
                if (str.trim() == "") {
                  endIcon = null;
                  text = null;
                  // errorShown = true;
                } else {
                  text = str;
                  if (widget.formFieldValidator(str) == null) {
                    setState(() {
                      showSuffixIcon = true;
                      endIcon = const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                      );
                      // errorShown = false;
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
                    // errorShown = true;
                  }
                }
              },
          decoration: InputDecoration(
              // errorText: null,
              // errorBorder: OutlineInputBorder(
              //     borderSide: BorderSide.none,
              //     borderRadius: BorderRadius.circular(12)),
              // errorStyle: TextStyle(
              //   height: 0
              // // errorStyle: TextStyle(),
              // ),
              // focusedErrorBorder: InputBorder.none,
              // errorMaxLines: null,
              fillColor: AppColors.gray07,
              filled: true,
              hintText: widget.hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.gray03),
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
        // Positioned(
        //   top: 20,
        //   child: Visibility(
        //     visible: showHint,
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.translucent,
        //       onTap: () {
        //         if (focusNode.hasFocus) {
        //           focusNode.unfocus();
        //         } else {
        //           focusNode.requestFocus();
        //         }
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 10.0,),
        //         child: widget.hint,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
