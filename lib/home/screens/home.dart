import 'package:flutter/material.dart';

import '../../home/widgets/like_item_display.dart';
import '../../home/widgets/popular_item_card.dart';
import '../../models/product_model.dart';
import '../../repositories/database_repository.dart';
import '../../utils/app_images.dart';
import '../../utils/appstyles.dart';

import '../widgets/category_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bigSpace = 30.0;
    const smallSpace = 20.0;
    final DatabaseRepository databaseRepository = DatabaseRepository();
    final fetchCategories = databaseRepository.fetchCategories();

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
                  child: FutureBuilder(
                    future: fetchCategories,
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        if (snapShot.hasData) {
                          List<ProductModel> categories =
                              snapShot.data as List<ProductModel>;
                          return ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                return CategoryCard(
                                  title: categories[index].title,
                                  imageUrl: categories[index].imageUrl,
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
              const SizedBox(
                height: bigSpace,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: StreamBuilder(
                    stream: databaseRepository.fetchAllItems(),
                    builder: (context, snapShot) {
                      //TODO add the error builder
                      if (snapShot.hasData) {
                        final result = snapShot.data;
                        final docs = result!.docs;

                        return ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: docs.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            itemBuilder: (context, index) {
                              return LikeItemDisplay(
                                  imageLink: docs[index]["image_url"],
                                  title: docs[index]["title"],
                                  amount: docs[index]["amount"],
                                  rating: double.tryParse(
                                      docs[index]["rating"].toString())!);
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
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
                child:
                 StreamBuilder(
                   stream: databaseRepository.fetchPopularItems(),
                   builder: (context,snapShot) {
                     if (snapShot.hasData){
                       final result = snapShot.data;
                       final docs = result!.docs;
                       // print ("docs is $docs");
                       return ListView.separated(
                           shrinkWrap: true,
                           scrollDirection: Axis.horizontal,
                           itemCount: docs.length,
                           separatorBuilder: (context, index) {
                             return const SizedBox(
                               width: 20,
                             );
                           },
                           itemBuilder: (context, index) {
                             return PopularItemCard(
                               imageUrl: docs[index]["image_url"],
                               itemName: docs[index]["title"],
                               amount: docs[index]["amount"],
                             );
                           });
                     }else{
                       return const Center(
                         child: CircularProgressIndicator(),
                       );
                     }
                   },
                 )


              ),
            ],
          ),
        ),
      )),
    );
  }
}
