import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.gray07,
              blurRadius: 20,
              spreadRadius: 0,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: SvgPicture.asset(AppImages.faceBook)),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 12, color: Colors.black),
          )
        ],
      ),
    );
  }
}
