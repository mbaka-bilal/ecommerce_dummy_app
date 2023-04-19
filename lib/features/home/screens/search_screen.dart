import 'package:ecommerce_dummy_app/bloc/search_products_bloc.dart';
import 'package:ecommerce_dummy_app/bloc/search_products_state.dart';
import 'package:ecommerce_dummy_app/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product_model.dart';
import '../../home/widgets/like_item_display.dart';

import '../../../utils/appstyles.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
                        RepositoryProvider.of<DatabaseRepository>(context)
                            .searchProducts(str);
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
                  // InkWell(
                  //   onTap: () {
                  //     //TODO show the filter options
                  //   },
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 5),
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         color: AppColors.blue,
                  //         borderRadius: BorderRadius.circular(12)),
                  //     child: const Icon(
                  //       Icons.menu_sharp,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<SearchProductBloc, SearchProductState>(
                    builder: (context, state) {
                  if (state.status == SearchProductsEnum.success) {
                    if (state.products.isEmpty){
                      return const Center(
                        child: Text("No result"),
                      );
                    }else{
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
                                rating: double.tryParse("${state.products[index].rating}")!,
                                imageLink: state.products[index].imageUrl);
                          });
                    }

                  }else if (state.status == SearchProductsEnum.initial) {
                    return Container();
                  }else{
                    return Text("Error");
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
