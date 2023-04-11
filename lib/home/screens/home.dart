import 'package:ecommerce_dummy_app/home/widgets/like_item_display.dart';
import 'package:ecommerce_dummy_app/home/widgets/popular_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';
import '../widgets/category_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bigSpace = 30.0;
    const smallSpace = 20.0;

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        //TODO show app drawer
                      },
                      child: const Icon(
                        Icons.menu,
                      )),
                  ClipOval(
                    child: Image.asset(
                      AppImages.defaultProfilePicPng,
                      scale: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                "Find your favourite Products",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.gray04),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.gray03,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: AppColors.gray07,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  const SizedBox(
                    width: smallSpace,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO show the filter options
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.menu_sharp,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: bigSpace,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        title: "Clothes",
                      );
                    }),
              ),
              const SizedBox(
                height: bigSpace,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return LikeItemDisplay(
                          title: "Smart Bag", amount: 250, rating: 4.5);
                    }),
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "View All",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.gray03,
                            fontSize: 12,
                          ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: bigSpace,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return PopularItemCard(
                        itemName: "Thin chair",
                        amount: 99,
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
