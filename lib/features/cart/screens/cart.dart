import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_dummy_app/features/checkout/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cart_bloc.dart';
import '../../../bloc/cart_event.dart';
import '../../../bloc/cart_state.dart' as cart_state;
import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';

import '../../../widgets/mybutton.dart';

class CartScreen extends StatelessWidget {
  ///The cart screen
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.gray,
              ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, boxConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: boxConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<CartBloc, cart_state.CartState>(
                builder: (context, state) {
                  print("item count is ${state.items.length}");

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ...state.items.map((e) => CartItem(
                                itemName: e.itemName,
                                imageUrl: e.imageUrl,
                                itemCount: e.itemNumber,
                                amount: e.amount,
                              ))
                        ],
                      ),
                      Column(
                        children: [
                          TotalItemCount(
                            itemCount: state.totalItems,
                            totalAmount: state.totalCost,
                          ),
                          MyButton(
                            text: "Checkout",
                            buttonColor: AppColors.blue,
                            width: double.infinity,
                            height: 60,
                            function: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckOutScreen()));
                            },
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.itemName,
      required this.imageUrl,
      required this.amount,
      required this.itemCount})
      : super(key: key);

  final String itemName;
  final String imageUrl;
  final int amount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: double.infinity,
          height: 130,
          color: Colors.white,
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: constraints.maxWidth / 3.5,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                            color: AppColors.gray07,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.fill,
                            ))),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          itemName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<CartBloc>().add(CartRemove(
                                        item: cart_state.CartItem(
                                      amount: amount,
                                      itemName: itemName,
                                      imageUrl: imageUrl,
                                    )));
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
                              width: 10,
                            ),
                            Text(
                              "$itemCount",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: AppColors.gray, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                context.read<CartBloc>().add(CartAdd(
                                        item: cart_state.CartItem(
                                      amount: amount,
                                      itemName: itemName,
                                      imageUrl: imageUrl,
                                    )));
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
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(CartDelete(
                                item: cart_state.CartItem(
                              amount: amount,
                              itemName: itemName,
                              imageUrl: imageUrl,
                            )));
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "N $amount",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.blue,
                          ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class TotalItemCount extends StatelessWidget {
  const TotalItemCount(
      {Key? key, required this.itemCount, required this.totalAmount})
      : super(key: key);

  final int itemCount;
  final int totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 20),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Selected item ($itemCount)",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.gray,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Cost : ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.gray03,
                        ),
                  )
                ],
              ),
              Text("N $totalAmount",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.gray,
                        fontSize: 20,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
