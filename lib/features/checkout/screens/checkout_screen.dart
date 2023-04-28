import 'package:ecommerce_dummy_app/repositories/database_repository.dart';
import 'package:ecommerce_dummy_app/utils/app_utils.dart';
import 'package:ecommerce_dummy_app/widgets/my_form.dart';
import 'package:ecommerce_dummy_app/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/constants.dart';

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
  Map<String,dynamic> _chosenAddress = {};


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
                              )).then((value) => setState(() {
                            print("reload");
                          }));
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
              // const LocationCard(
              //   title: "Home",
              //   address: "New Iskaton, Barlinarpur-2148, Adorana, Agartine",
              //   mobileNumber: "+880 1224 1573 ",
              //   isSelected: false,
              // ),
              // const LocationCard(
              //   title: "Home",
              //   address: "New Iskaton, Barlinarpur-2148, Adorana, Agartine",
              //   mobileNumber: "+880 1224 1573 ",
              //   isSelected: false,
              // ),
              FutureBuilder(
                  future: DatabaseRepository().fetchAddresses("addresses"),
                  builder: (context,snapShot) {
                    if (snapShot.hasData){
                    final data = snapShot.data as List<Map<String,dynamic>>;
                    //default our chosen address is the first one;
                    _chosenAddress = data[0];

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
                            child: LocationCard(
                              // title: "Home",
                              address: data[index]["name"],
                              mobileNumber: data[index]["phone_number"],
                              isSelected: (_chosenAddressIndex == index) ? true : false,
                            ),
                          ),
                      ));
                    }else{
                      return Container();
                    }
                  }
              ),
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
                    onTap: () {},
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
              ...List.generate(
                2,
                (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _chosenCardIndex = index;
                      });
                    },
                    child: DebitCard(
                      cardType: CardTypes.masterCard,
                      cardNumber: "121212121212121212",
                      isSelected: (_chosenCardIndex == index) ? true : false,
                    )),
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
                function: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard(
      {Key? key,
      // required this.title,
      required this.address,
      required this.isSelected,
      required this.mobileNumber})
      : super(key: key);

  // final String title;
  final String address;
  final bool isSelected;
  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.blue,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: (isSelected) ? AppColors.blue : Colors.white,
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   title,
                    //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    //         fontSize: 16,
                    //       ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      address,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14, color: AppColors.gray04),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Mobile: ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 14, color: AppColors.gray02),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          mobileNumber,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 14, color: AppColors.gray03),
                        )
                      ],
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    //Show options to edit and delete this item.
                  },
                  child: Row(
                      children: List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(right: 5),
                      // padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: AppColors.gray04,
                      ),
                    ),
                  )),
                ))
          ],
        ),
      ),
    );
  }
}

enum CardTypes {
  masterCard,
  visaCard,
}

class DebitCard extends StatelessWidget {
  const DebitCard({
    Key? key,
    required this.cardType,
    required this.cardNumber,
    required this.isSelected,
  }) : super(key: key);

  final CardTypes cardType;
  final String cardNumber;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(AppImages.masterCardPng),
                const SizedBox(
                  width: 10,
                ),
                Text(cardNumber.hideCardInfo),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.blue,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: (isSelected) ? AppColors.blue : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAdressCard extends StatelessWidget {
  const AddAdressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final databaseRepo = DatabaseRepository();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 200,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      hintText: "Enter address",
                      fillColor: AppColors.gray07,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12))),
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  controller: addressController,
                )),
            const SizedBox(
              height: smallSpace,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter phone number",
                  fillColor: AppColors.gray07,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12))),
              controller: phoneNumberController,
            ),
            const SizedBox(
              height: smallSpace,
            ),
            MyButton(
              text: "Done",
              buttonColor: AppColors.blue,
              width: double.infinity,
              height: 50,
              function: () async {
                try {
                  if (await databaseRepo.checkIfDatabaseExists("addresses")) {
                    //Add record to the database
                    if (addressController.text.trim().isEmpty ||
                        phoneNumberController.text.trim().isEmpty) {
                      throw EmptyFieldException();
                    }
                    await databaseRepo.addAddressToDatabase("addresses",
                        addressController.text, phoneNumberController.text);
                  } else {
                    await databaseRepo.createDatabaseAndTable("addresses");
                  }
                } catch (e) {
                  String error = e.toString();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text((error.contains("UNIQUE constraint failed"))
                        ? "Address already exists"
                        : "Error could not add to database"),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
