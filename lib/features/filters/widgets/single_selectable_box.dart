import 'package:flutter/material.dart';

import '../../../utils/appstyles.dart';

class SingleSelectableBox extends StatelessWidget {
  const SingleSelectableBox({
    Key? key,
    required this.selected,
    required this.title,
  }) : super(key: key);

  final bool selected;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: selected ? AppColors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          (title == null) ? " " : title!,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: selected ? Colors.white : AppColors.gray02),
        ));
  }
}
