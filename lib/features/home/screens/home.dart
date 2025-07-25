import 'package:ecommerce_dummy_app/features/product_info/screens/product_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/category_card.dart';
import '../widgets/like_item_display.dart';
import '../widgets/popular_item_card.dart';

import '../../category/screens/category_screen.dart';
import '../../filters/screens/filters_screen.dart';
import '../../home/screens/search_screen.dart';

import '../../../bloc/popular_products_bloc.dart';
import '../../../bloc/popular_products_state.dart';
import '../../../bloc/product_bloc.dart';
import '../../../bloc/product_state.dart';
import '../../../models/product_model.dart';
import '../../../repositories/database_repository.dart';
import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';

enum ProductType { latestProduct, popularProduct }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const bigSpace = 30.0;
  static const smallSpace = 20.0;
  final _latestProductScrollController = ScrollController();
  final _popularProductScrollController = ScrollController();
  final fetchCategories = DatabaseRepository().fetchCategories();

  @override
  void initState() {
    super.initState();
    RepositoryProvider.of<DatabaseRepository>(context).fetchProducts();
    RepositoryProvider.of<DatabaseRepository>(context).fetchPopularProducts();
    _latestProductScrollController.addListener(() {
      _scrollListener(
        _latestProductScrollController,
        ProductType.latestProduct,
      );
    });
    _popularProductScrollController.addListener(() {
      _scrollListener(
        _popularProductScrollController,
        ProductType.popularProduct,
      );
    });
  }

  void _scrollListener(ScrollController scrollController, ProductType type) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = (currentScroll / maxScroll) * 100;

    if (scrollPercentage >= 90) {
      // if (kDebugMode) {
      //   print("at 90% for $type");
      //   print("the document snapshot is "
      //       "${context.read<ProductBloc>().state.products.last.documentSnapshot}");
      // }
      switch (type) {
        case ProductType.latestProduct:
          RepositoryProvider.of<DatabaseRepository>(context).fetchProducts(
            context.read<ProductBloc>().state.products.last.documentSnapshot,
          );
          break;
        case ProductType.popularProduct:
          RepositoryProvider.of<DatabaseRepository>(
            context,
          ).fetchPopularProducts(
            context
                .read<PopularProductsBloc>()
                .state
                .popularProducts
                .last
                .documentSnapshot,
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        //TODO show app drawer
                      },
                      child: const Icon(Icons.menu),
                    ),
                    ClipOval(
                      child: Image.asset(
                        AppImages.defaultProfilePicPng,
                        scale: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: bigSpace),
                Text(
                  "Find your favourite Products",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: bigSpace),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchResultScreen(
                                searchFieldSelected: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: AppColors.gray07,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.search,
                                color: AppColors.gray03,
                                size: 20,
                              ),
                              Text(
                                "Search",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: AppColors.gray04),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: smallSpace),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FilterScreen(
                              navigateToSearchScreen: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset(AppImages.filters),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: bigSpace),
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
                              return const SizedBox(width: 10);
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                        categoryTitle: categories[index].title,
                                      ),
                                    ),
                                  );
                                },
                                child: CategoryCard(
                                  title: categories[index].title,
                                  imageUrl: categories[index].imageUrl,
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                const SizedBox(height: smallSpace),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Latest",
                //       style: Theme.of(context)
                //           .textTheme
                //           .bodyMedium!
                //           .copyWith(fontSize: 16),
                //     ),
                //     InkWell(
                //       onTap: () {},
                //       child: Text(
                //         "View All",
                //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //               color: AppColors.gray03,
                //               fontSize: 12,
                //             ),
                //       ),
                //     )
                //   ],
                // ),
                const SizedBox(height: smallSpace),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state.status == ProductStatus.success) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.separated(
                          controller: _latestProductScrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.products.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 20);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductInfo(
                                      documentID:
                                          state.products[index].documentID,
                                      imageUrl: state.products[index].imageUrl,
                                      productCost:
                                          state.products[index].amount!,
                                      productDescription:
                                          state.products[index].description!,
                                      productName: state.products[index].title!,
                                      productRating: double.tryParse(
                                        "${state.products[index].rating}",
                                      )!,
                                    ),
                                  ),
                                );
                              },
                              child: LikeItemDisplay(
                                imageLink: state.products[index].imageUrl,
                                title: state.products[index].title,
                                amount: state.products[index].amount!,
                                documentID: state.products[index].documentID,
                                rating: double.tryParse(
                                  "${state.products[index].rating}",
                                )!,
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state.status == ProductStatus.initial) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Text("Error");
                    }
                  },
                ),
                const SizedBox(height: smallSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Text(
                    //     "View All",
                    //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //           color: AppColors.gray03,
                    //           fontSize: 12,
                    //         ),
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(height: smallSpace),
                BlocBuilder<PopularProductsBloc, PopularProductState>(
                  builder: (context, state) {
                    if (state.status == PopularProductStatus.success) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: ListView.separated(
                          controller: _popularProductScrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.popularProducts.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 20);
                          },
                          itemBuilder: (context, index) {
                            // print("the docs is ${docs[index]["title"]}");

                            return PopularItemCard(
                              imageUrl: state.popularProducts[index].imageUrl,
                              itemName: state.popularProducts[index].title,
                              amount: 1000,
                            );
                          },
                        ),
                      );
                    } else if (state.status == PopularProductStatus.initial) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (state.popularProducts.isNotEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: ListView.separated(
                            controller: _popularProductScrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.popularProducts.length + 1,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 20);
                            },
                            itemBuilder: (context, index) {
                              if (index == state.popularProducts.length) {
                                return const Text("Error");
                              } else {
                                return PopularItemCard(
                                  imageUrl:
                                      state.popularProducts[index].imageUrl,
                                  itemName: state.popularProducts[index].title,
                                  amount: 1000,
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return const Text("Error");
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
