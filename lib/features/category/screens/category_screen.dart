import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/filter_options.dart';
import '../../../bloc/filter_product_bloc.dart';
import '../../../bloc/filter_product_state.dart';
import '../../../repositories/database_repository.dart';
import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/app_utils.dart';
import '../../filters/screens/filters_screen.dart';
import '../../home/widgets/like_item_display.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.categoryTitle})
      : super(key: key);

  final String? categoryTitle;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<FilterOptionsBloc>().state;

    RepositoryProvider.of<DatabaseRepository>(context).filterProduct(
      collectionName: "items",
      category: widget.categoryTitle,
      rating: provider.rating,
      priceRange: provider.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (str) {
                            context.read<FilterProductBloc>().emit(
                                const FilterProductState(
                                    status: FilterProductStatus.loading));
                            RepositoryProvider.of<DatabaseRepository>(context)
                                .filterProduct(
                              collectionName: "items",
                              searchString: str,
                              category: widget.categoryTitle,
                              priceRange:
                                  context.read<FilterOptionsBloc>().state.price,
                              rating: context
                                  .read<FilterOptionsBloc>()
                                  .state
                                  .rating,
                            );
                          },
                          // focusNode: _focusNode,
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
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FilterScreen(
                                    navigateToSearchScreen: false,
                                    category: widget.categoryTitle,
                                  )));
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            child: SvgPicture.asset(AppImages.filters)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Category : ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.gray04,
                                  fontSize: 14,
                                ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            (widget.categoryTitle == null)
                                ? " "
                                : widget.categoryTitle!.convertFirstToUpperCase,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.blue,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: DatabaseRepository().countDocumentsInCollection(
                            collectionName: "items",
                            categoryName: widget.categoryTitle),
                        builder: (context, snapShotState) {
                          if (snapShotState.hasData) {
                            final data = snapShotState.data;
                            return Row(
                              children: [
                                Text(
                                  "${data!.count} total items",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.gray04,
                                        fontSize: 14,
                                      ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  AppImages.boxLines,
                                  color: AppColors.gray,
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocListener<FilterOptionsBloc, FilterOptions>(
                    listener: (context, state) {
                      // print ("values changed");
                      RepositoryProvider.of<DatabaseRepository>(context)
                          .filterProduct(
                        collectionName: "items",
                        category: widget.categoryTitle,
                        rating: state.rating,
                        priceRange: state.price,
                      );
                    },
                    child: Expanded(
                      child: BlocBuilder<FilterProductBloc, FilterProductState>(
                          builder: (context, state) {
                        if (state.status == FilterProductStatus.success) {
                          if (state.products.isEmpty) {
                            return const Center(
                              child: Text("No result"),
                            );
                          } else {
                            return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  return LikeItemDisplay(
                                      documentID:
                                          state.products[index].documentID,
                                      title: state.products[index].title,
                                      amount: state.products[index].amount!,
                                      rating: double.tryParse(
                                          "${state.products[index].rating}")!,
                                      imageLink:
                                          state.products[index].imageUrl);
                                });
                          }
                        } else if (state.status ==
                            FilterProductStatus.initial) {
                          return Container();
                        } else if (state.status ==
                            FilterProductStatus.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Text("Error");
                        }
                      }),
                    ),
                  ),
                ]))));
  }
}
