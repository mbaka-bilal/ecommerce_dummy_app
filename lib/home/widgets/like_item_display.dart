import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

class LikeItemDisplay extends StatelessWidget {
  /// Widget to show the item with only the like available
  /// but no add to cart
  const LikeItemDisplay({Key? key, required this.title, required this.amount, required this.rating}) : super(key: key);

  final String title;
  final int amount;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.gray07,
      elevation: 10,
      child: Container(
        width: 150,
        height: 170,
        color: Colors.white,
        child: Container(
          // color: Color(0xFFFFFFFF),
          // surfaceTintColor: null,
          // elevation: 10,
          // shadowColor: AppColors.gray07,

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                          width: double.infinity,
                          // height: 100,
                          // height: 80,
                          // width: 80,
                          //   margin: EdgeInsets.all(10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(12),
                              color: AppColors.gray07),
                          child:
                          SvgPicture.asset(AppImages.faceBook)),
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.favorite,color: Colors.red,),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                          fontSize: 12,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      // color: Colors.blue,
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$$amount",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                color: AppColors.blue),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                rating.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color:
                                    AppColors.gray03),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
