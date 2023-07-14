import 'package:ecommerce_dummy_app/models/card_model.dart';
import 'package:flutter/material.dart';

import '../../../repositories/database_repository.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/constants.dart';
import '../../../common/screens/add_card_screen.dart';
import '../../../widgets/mybutton.dart';
import '../components/add_address_dialog.dart';
import '../components/card_widget.dart';
import '../components/checkout_card_dialog.dart';
import '../components/location_card.dart';

class CheckOutScreen extends StatefulWidget {
  ///The checkout screen

  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  static const bigSpace = 20.0;
  static const smallSpace = 10.0;
  int _chosenAddressIndex = 0;
  int _chosenCardIndex = 0;
  Map<String, dynamic> _chosenAddress = {};
  final _databaseRepository = DatabaseRepository();

  void refreshScreen() {
    setState(() {});
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
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: bigSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping To",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      final controller = TextEditingController();

                      //Show bottom sheet to add new address
                      showDialog(
                          context: context,
                          builder: (context) => const Dialog(
                                child: AddAdressCard(),
                              )).then((value) => setState(() {}));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColors.gray04,
                        ),
                        const SizedBox(
                          width: smallSpace,
                        ),
                        Text("Add New",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 12, color: AppColors.gray04)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: bigSpace,
              ),
              FutureBuilder(
                  future: DatabaseRepository()
                      .fetchRecordFromLocalDatabase(dtb_user, tbl_address),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      final data = snapShot.data as List<Map<String, dynamic>>;
                      //default our chosen address is the first one;
                      // _chosenAddress = data[0];

                      return Column(
                          children: List.generate(
                        data.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              _chosenAddressIndex = index;
                              //update chosen address.
                              _chosenAddress = data[index];
                            });
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            background: const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )),
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                              await _databaseRepository
                                  .deleteRecordFromLocalDatabase(
                                      databaseName: dtb_user,
                                      tableName: tbl_address,
                                      columnId: "name",
                                      args: data[index]["name"])
                                  .then((value) => refreshScreen());
                            },
                            child: LocationCard(
                              // title: "Home",
                              address: data[index]["name"],
                              mobileNumber: data[index]["phone_number"],
                              isSelected:
                                  (_chosenAddressIndex == index) ? true : false,
                            ),
                          ),
                        ),
                      ));
                    } else {
                      return Container();
                    }
                  }),
              const SizedBox(height: bigSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Method",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddCardScreen(
                                callBack: refreshScreen,
                              )));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColors.gray04,
                        ),
                        const SizedBox(
                          width: smallSpace,
                        ),
                        Text("Add New",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 12, color: AppColors.gray04)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: bigSpace),
              FutureBuilder(
                future: DatabaseRepository()
                    .fetchRecordFromLocalDatabase(dtb_user, tbl_cards),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    List<Map<String, dynamic>> cards =
                        snapShot.data as List<Map<String, dynamic>>;
                    return Column(
                      children: List.generate(
                        cards.length,
                        (index) => InkWell(onTap: () {
                          setState(() {
                            _chosenCardIndex = index;
                          });
                        }, child: Builder(
                          builder: (context) {
                            final card = CardModel(
                                cardNumber: cards[index]["card_number"],
                                cardHolder: cards[index]["card_holder"],
                                cardType: "Debit",
                                cvv: cards[index]["cvv"],
                                expiryMonth: cards[index]["expiration_month"],
                                expiryYear: cards[index]["expiration_year"]);
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )),
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await _databaseRepository
                                    .deleteRecordFromLocalDatabase(
                                        databaseName: dtb_user,
                                        tableName: tbl_cards,
                                        columnId: "card_number",
                                        args: card.cardNumber)
                                    .then((value) => refreshScreen());
                              },
                              child: DebitCard(
                                // cardType: CardTypes.masterCard,
                                cardNumber: card.cardNumber,
                                isSelected:
                                    (_chosenCardIndex == index) ? true : false,
                              ),
                            );
                          },
                        )),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: bigSpace),
              Card(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Details",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: smallSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub Total: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14, color: AppColors.gray03),
                          ),
                          Text("N 3000",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 14))
                        ],
                      ),
                      const SizedBox(
                        height: smallSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Fee: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 14, color: AppColors.gray03)),
                          Text("N 200",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 14))
                        ],
                      ),
                      const SizedBox(
                        height: bigSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pay: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 14, color: AppColors.gray03)),
                          Text("N 3200",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: bigSpace,
              ),
              MyButton(
                text: "Payment",
                buttonColor: AppColors.blue,
                width: double.infinity,
                height: 50,
                function: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            // insetPadding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.white,
                            child: const CheckoutDialog(
                              cardNumber: "21212",
                              cvv: 's111',
                              date: '01/23',
                              holdersName: 'jhone doe',
                            ));
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
