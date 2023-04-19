import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import '../../../utils/appstyles.dart';


class LikeItemDisplay extends StatelessWidget {
  /// Widget to show the item with only the like available
  /// but no add to cart
  const LikeItemDisplay({Key? key, required this.title, required this.amount, required this.rating, required this.imageLink}) : super(key: key);

  final String title;
  final int amount;
  final double rating;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.gray07,
      elevation: 10,
      child: Container(
        width: 150,
        height: 170,
        color: Colors.white,
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(12),
                            color: AppColors.gray07),
                        child:
                        CachedNetworkImage(
                          imageUrl: imageLink,
                        )),
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            //TODO add to favorites
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.favorite,color: Colors.red,),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
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
                        "$rating",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                            color:
                            AppColors.gray03),
                      ),

                    ],
                  )
                ],
              ),

                  const SizedBox(
                    height: 3,
                  ),
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
                  SizedBox(
                    // color: Colors.blue,
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "N$amount",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              color: AppColors.blue),
                        ),

                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(360)
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white
                            ),
                          ),
                        ),
]
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
