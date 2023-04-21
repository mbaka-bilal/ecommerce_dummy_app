import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_dummy_app/utils/appstyles.dart';
import 'package:ecommerce_dummy_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/favorite_bloc.dart';
import '../../../repositories/database_repository.dart';
import '../../../utils/app_images.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo(
      {Key? key,
      required this.imageUrl,
      required this.productName,
      required this.productDescription,
      required this.productRating,
      required this.productCost, required this.documentID})
      : super(key: key);

  final String imageUrl;
  final String productName;
  final String productDescription;
  final double productRating;
  final int productCost;
  final String documentID;

  @override
  Widget build(BuildContext context) {
    const bigSpace = 20.0;
    const smallSpace = 10.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          productName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                //TODO navigate to the checkout screen
              },
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.gray03,
              ))
        ],
      ),
      body: SingleChildScrollView(
        //TODO make the appBar animate to put image of the picture there.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray07,
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    // clipBehavior: Clip.antiAlias,
                    children: [
                      Positioned.fill(
                          child: Transform.scale(
                            scale: 0.8,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                            ),
                          )),
                      Align(
                          alignment: Alignment.topRight,
                          child: BlocBuilder<FavoriteBloc, List<dynamic> >(

                            builder: (context, state) {

                              return InkWell(
                                onTap: () async {
                                  if (state.contains(documentID)){
                                    context.read<FavoriteBloc>().removeDoc(documentID);
                                    await DatabaseRepository().updateFavoriteProducts(state, FirebaseAuth.instance.currentUser!.uid);
                                  }else{
                                    context.read<FavoriteBloc>().addDoc(documentID);
                                    await DatabaseRepository().updateFavoriteProducts(state, FirebaseAuth.instance.currentUser!.uid);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, right: 5),
                                  child: Icon(
                                    Icons.favorite,
                                    color: (state.contains(documentID))
                                        ? Colors.red
                                        : AppColors.gray04,
                                  ),
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.gray, fontSize: 20),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //TODO decrease the item count
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.gray05,
                              borderRadius: BorderRadius.circular(3)),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: smallSpace,
                      ),
                      Text(
                        '1',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.gray, fontSize: 20),
                      ),
                      const SizedBox(
                        width: smallSpace,
                      ),
                      InkWell(
                        onTap: () {
                          //TODO increase the item count
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.gray03,
                              borderRadius: BorderRadius.circular(3)),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: smallSpace,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.alert,
                  ),
                  const SizedBox(
                    width: smallSpace,
                  ),
                  Text(
                    productRating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14, color: AppColors.gray03),
                  )
                ],
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                "N$productCost",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 28, color: AppColors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                productDescription,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.gray04),
              ),
              const SizedBox(
                height: bigSpace,
              ),
              MyButton(
                text: "Add to Cart",
                width: double.infinity,
                height: 50,
                buttonColor: AppColors.blue,
                function: () {
                  //TODO add the item to the cart
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
