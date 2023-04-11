import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

class PopularItemCard extends StatelessWidget {
  ///Widget to display the popular items
  const PopularItemCard({Key? key, required this.itemName, required this.amount}) : super(key: key);

  final String itemName;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.white,
      elevation: 10,
      shadowColor: AppColors.gray07,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.gray07,
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(AppImages.faceBook),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemName),
                    SizedBox(
                      height: 5,
                    ),
                    Text("\$$amount")
                  ],
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, right: 8),
                  child: CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
