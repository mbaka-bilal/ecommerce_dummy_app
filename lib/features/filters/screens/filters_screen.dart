import 'package:ecommerce_dummy_app/models/product_model.dart';
import 'package:ecommerce_dummy_app/repositories/database_repository.dart';
import 'package:ecommerce_dummy_app/utils/appstyles.dart';
import 'package:ecommerce_dummy_app/widgets/mybutton.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

import '../../home/screens/search_screen.dart';
import '../widgets/single_selectable_box.dart';

class FilterScreen extends StatefulWidget {
  ///Filter products screen
  ///
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String _chosenCategory = "cosmetics";
  String _chosenType = "lowest";
  final _fetchCategories = DatabaseRepository().fetchCategories();
  double _chosenPriceRange = 10.0;
  final List<String> _types = ["lowest", "highest", "best", "newest"];
  int _selectedRating = 5;
  static const _bigSpace = 20.0;
  static const _smallSpace = 10.0;

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
                _chosenCategory = "cosmetics";
                _chosenType = "lowest";
                _chosenPriceRange = 10.0;
                _selectedRating = 5;
              });
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
                                    selected: (_chosenCategory == e.title)
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
                    "\$10",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color:
                            (_chosenPriceRange >= 10 && _chosenPriceRange < 500)
                                ? AppColors.gray
                                : AppColors.gray03,
                        fontSize:
                            (_chosenPriceRange >= 10 && _chosenPriceRange < 500)
                                ? 14
                                : 12),
                  ),
                  Text("\$500",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: (_chosenPriceRange >= 500 &&
                                  _chosenPriceRange < 1000)
                              ? AppColors.gray
                              : AppColors.gray03,
                          fontSize: (_chosenPriceRange >= 500 &&
                                  _chosenPriceRange < 1000)
                              ? 14
                              : 12)),
                  Text("\$1000",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: (_chosenPriceRange == 1000)
                              ? AppColors.gray
                              : AppColors.gray03,
                          fontSize: (_chosenPriceRange == 1000) ? 14 : 12))
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
                    if (foundation.kDebugMode) {
                      print("the chosen price range is ${_chosenPriceRange}");
                    }
                  });
                },
                thumbColor: AppColors.blue,
                activeColor: AppColors.blue,
                max: 1000,
                min: 10,
              ),
              const SizedBox(
                height: _bigSpace,
              ),
              Text("Sort By",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, color: AppColors.gray)),
              const SizedBox(
                height: _smallSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.of(_types)
                    .map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _chosenType = e;
                            });
                          },
                          child: SingleSelectableBox(
                            title: e,
                            selected: (_chosenType == e) ? true : false,
                          ),
                        ))
                    .toList(),
              ),
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
                children: [5, 4, 3, 2]
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(
                                    e,
                                    (index) => const Icon(
                                          Icons.star,
                                          color: AppColors.alert,
                                        )),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedRating = e;
                                    });
                                  },
                                  child: Icon(
                                    Icons.check_circle,
                                    color: (_selectedRating == e)
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
                  //TODO apply the filter
                  Navigator.of(context).pop();
                },
                height: 60,
                buttonColor: AppColors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
