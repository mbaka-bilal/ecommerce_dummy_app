import 'package:flutter/material.dart';

import '../utils/appstyles.dart';

class CircleProgress extends StatelessWidget {
  const CircleProgress({Key? key, required this.index, required this.range})
      : super(key: key);

  final int index;
  final int range;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(range, (currentIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor:
              (currentIndex == index) ? AppColors.blue : Colors.grey,
              radius: 5,
            ),
          );
        })
    );
  }
}