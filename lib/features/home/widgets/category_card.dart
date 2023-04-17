import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/appstyles.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 10,),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.white),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                )),
          ),
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
