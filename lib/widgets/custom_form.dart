import 'package:flutter/material.dart';

import '../utils/appstyles.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    Key? key,
    required this.hint,
    this.trailingIcon,
    required this.isPassword,
    required this.textEditingController,
    this.formFieldValidator,
    this.formKey,
    this.maxLines,
    this.minLines,
    this.expands = false,
    this.keyboardType,
    this.onChanged,
    this.onTapOutside,
    this.onEditingComplete,
    this.focusNode,
    this.maxLength,
  }) : super(key: key);

  final String hint;
  final Widget? trailingIcon;
  final bool isPassword;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?>? formFieldValidator;
  final GlobalKey<FormState>? formKey;
  final TextInputType? keyboardType;
  final bool expands;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String?>? onChanged;
  final Function()? onEditingComplete;
  final Function(PointerEvent event)? onTapOutside;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  // final focusNode = FocusNode();
  bool showHint = true;
  bool hidePassword = true;
  bool showSuffixIcon = false;
  String? text;
  Widget? endIcon;

  // bool errorShown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      readOnly: false,
      focusNode: widget.focusNode,
      textAlignVertical: TextAlignVertical.top,
      expands: widget.expands,
      // maxLines: (widget.expands) ? null : widget.maxLines,
      minLines: (widget.expands) ? null : widget.minLines,
      keyboardType: widget.keyboardType,
      validator: widget.formFieldValidator,
      // focusNode: focusNode,
      controller: widget.textEditingController,
      obscureText: (widget.isPassword) ? hidePassword : false,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onTapOutside: widget.onTapOutside,
      decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.gray03),
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
    );
  }
}
