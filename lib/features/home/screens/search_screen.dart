import 'package:ecommerce_dummy_app/bloc/filter_options.dart';
import 'package:ecommerce_dummy_app/bloc/search_products_bloc.dart';
import 'package:ecommerce_dummy_app/bloc/search_products_state.dart';
import 'package:ecommerce_dummy_app/features/dashboard/screens/dashboard.dart';
import 'package:ecommerce_dummy_app/features/filters/screens/filters_screen.dart';
import 'package:ecommerce_dummy_app/features/home/screens/home.dart';
import 'package:ecommerce_dummy_app/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/filter_product_bloc.dart';
import '../../../bloc/filter_product_event.dart';
import '../../../bloc/filter_product_state.dart';
import '../../../models/product_model.dart';
import '../../../utils/app_images.dart';
import '../../home/widgets/like_item_display.dart';

import '../../../utils/appstyles.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    Key? key,
    required this.searchFieldSelected,
  }) : super(key: key);

  final bool searchFieldSelected;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (!_focusNode.hasFocus && widget.searchFieldSelected) {
      _focusNode.requestFocus();
    }
    print("the filter is ${context.read<FilterOptionsBloc>().state}");
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashBoard()),
            (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const DashBoard()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                            category: context
                                .read<FilterOptionsBloc>()
                                .state
                                .category,
                            priceRange:
                                context.read<FilterOptionsBloc>().state.price,
                            rating:
                                context.read<FilterOptionsBloc>().state.rating,
                          );
                        },
                        focusNode: _focusNode,
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
                            builder: (context) => const FilterScreen(
                                  navigateToSearchScreen: false,
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
                  height: 20,
                ),
                Expanded(
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
                                  title: state.products[index].title,
                                  amount: state.products[index].amount!,
                                  rating: double.tryParse(
                                      "${state.products[index].rating}")!,
                                  imageLink: state.products[index].imageUrl);
                            });
                      }
                    } else if (state.status == FilterProductStatus.initial) {
                      return Container();
                    } else if (state.status == FilterProductStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Text("Error");
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
