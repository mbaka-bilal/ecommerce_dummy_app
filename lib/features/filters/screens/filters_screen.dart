import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/single_selectable_box.dart';

import '../../home/screens/search_screen.dart';

import '../../../bloc/filter_options.dart';
import '../../../models/product_model.dart';
import '../../../repositories/database_repository.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/mybutton.dart';

class FilterScreen extends StatefulWidget {
  ///Filter products screen
  /// Why navigateToSearchScreen?, it's because when you click on the search
  /// at home page it takes you to the search screen, but the filter screen
  /// can also be called from category and popular screen, if i don't add it
  /// when i pop the screen it will go back to the home page, no showing any
  /// effect.
  const FilterScreen(
      {Key? key, required this.navigateToSearchScreen, this.category})
      : super(key: key);

  final bool navigateToSearchScreen;
  final String? category;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _chosenCategory;
  String _chosenType = "lowest";
  final _fetchCategories = DatabaseRepository().fetchCategories();
  double _chosenPriceRange = 1000.0;
  double? _usedPrice;
  final List<String> _types = ["lowest", "highest", "best", "newest"];
  double? _selectedRating;
  static const _bigSpace = 20.0;
  static const _smallSpace = 10.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.navigateToSearchScreen) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      const SearchResultScreen(searchFieldSelected: false)),
              (route) => false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (widget.navigateToSearchScreen) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            const SearchResultScreen(searchFieldSelected: false)),
                    (route) => false);
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Filters",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.gray),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  if (widget.category == null) _chosenCategory = null;
                  _chosenType = "lowest";
                  _chosenPriceRange = 1000.0;
                  _selectedRating = null;
                });
                // context.read<FilterOptionsBloc>().resetState();
                context.read<FilterOptionsBloc>().updateState(
                  category: (widget.category == null)
                      ? null
                      : widget.category,
                  price:
                  null,
                  rating: null,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: _smallSpace),
                child: Text(
                  "Reset All",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.blue),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: _bigSpace, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: _bigSpace,
                ),
                if (widget.category == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16, color: AppColors.gray),
                      ),
                      const SizedBox(
                        height: _bigSpace,
                      ),
                      FutureBuilder(
                          future: _fetchCategories,
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              List<ProductModel> categories =
                                  snapShot.data as List<ProductModel>;
                              return Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: List.of(categories)
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _chosenCategory = e.title;
                                            });
                                          },
                                          child: SingleSelectableBox(
                                            title: e.title,
                                            selected:
                                                (_chosenCategory == e.title)
                                                    ? true
                                                    : false,
                                          ),
                                        ))
                                    .toList(),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      const SizedBox(
                        height: _bigSpace,
                      ),
                    ],
                  ),

                Text("Price",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, color: AppColors.gray)),
                const SizedBox(
                  height: _smallSpace,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "N1000",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: (_chosenPriceRange >= 1000 &&
                                  _chosenPriceRange < 50000)
                              ? AppColors.gray
                              : AppColors.gray03,
                          fontSize: (_chosenPriceRange >= 1000 &&
                                  _chosenPriceRange < 50000)
                              ? 14
                              : 12),
                    ),
                    Text("N50,000",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: (_chosenPriceRange >= 50000 &&
                                    _chosenPriceRange < 100000)
                                ? AppColors.gray
                                : AppColors.gray03,
                            fontSize: (_chosenPriceRange >= 50000 &&
                                    _chosenPriceRange < 100000)
                                ? 14
                                : 12)),
                    Text("N100,000",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: (_chosenPriceRange == 100000)
                                ? AppColors.gray
                                : AppColors.gray03,
                            fontSize: (_chosenPriceRange == 100000) ? 14 : 12))
                  ],
                ),
                const SizedBox(
                  height: _smallSpace,
                ),
                Slider(
                  value: _chosenPriceRange,
                  onChanged: (value) {
                    setState(() {
                      _chosenPriceRange = value;
                      _usedPrice = value;
                    });
                  },
                  thumbColor: AppColors.blue,
                  activeColor: AppColors.blue,
                  max: 100000,
                  min: 1000,
                ),
                //TODO implement sortBY
                // const SizedBox(
                //   height: _bigSpace,
                // ),
                // Text("Sort By",
                //     style: Theme.of(context)
                //         .textTheme
                //         .bodyMedium!
                //         .copyWith(fontSize: 16, color: AppColors.gray)),
                // const SizedBox(
                //   height: _smallSpace,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List.of(_types)
                //       .map((e) => GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 _chosenType = e;
                //               });
                //             },
                //             child: SingleSelectableBox(
                //               title: e,
                //               selected: (_chosenType == e) ? true : false,
                //             ),
                //           ))
                //       .toList(),
                // ),
                const SizedBox(
                  height: _bigSpace,
                ),
                Text("Rating",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, color: AppColors.gray)),
                const SizedBox(
                  height: _smallSpace,
                ),
                Column(
                  children: [5.0, 4.0, 3.0, 2.0]
                      .map((number) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: List.generate(
                                      number.toInt(),
                                      (index) => const Icon(
                                            Icons.star,
                                            color: AppColors.alert,
                                          )),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedRating = number;
                                      });
                                    },
                                    child: Icon(
                                      Icons.check_circle,
                                      color: (_selectedRating == number)
                                          ? AppColors.success
                                          : AppColors.gray06,
                                    ))
                              ],
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: _bigSpace,
                ),
                MyButton(
                  text: "Apply Filter",
                  width: double.infinity,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, color: Colors.white),
                  function: () {
                    context.read<FilterOptionsBloc>().updateState(
                          category: (widget.category == null)
                              ? _chosenCategory
                              : widget.category,
                          price:
                              (_usedPrice != null) ? _usedPrice!.toInt() : null,
                          rating: _selectedRating,
                        );

                    if (widget.navigateToSearchScreen) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SearchResultScreen(
                                  searchFieldSelected: false)),
                          (route) => false);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  height: 60,
                  buttonColor: AppColors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
