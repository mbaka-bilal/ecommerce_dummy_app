import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/card_model.dart';
import '../../repositories/database_repository.dart';
import '../../repositories/payment_repository.dart';
import '../../utils/app_utils.dart';
import '../../utils/appstyles.dart';
import '../../utils/constants.dart';
import '../../widgets/mybutton.dart';
import '../../widgets/custom_form.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key, required this.callBack}) : super(key: key);

  final Function callBack;

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final cardNumberController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final cvvController = TextEditingController();
  final cardHolderController = TextEditingController();
  final databaseRepository = DatabaseRepository();
  final monthFocusNode = FocusNode();

  //Loading indicator for checking card.
  bool _isCheckingCard = false;

  //Data about the current Card.
  ResolveCardBin? _resolveCardBin;

  Timer? _cardNumberTimer;
  final PaymentRepository _paymentRepository = PaymentRepository();

  Future<void> addCardToDatabase() async {
    var snackBar = ScaffoldMessenger.of(context);

    try {
      if (cardHolderController.text.trim().isEmpty ||
          monthController.text.trim().isEmpty ||
          yearController.text.trim().isEmpty ||
          cvvController.text.trim().isEmpty ||
          cardNumberController.text.trim().isEmpty) {
        throw EmptyFieldException();
      }

      await databaseRepository.addRecordToTable(
          databaseName: dtb_user,
          tableName: tbl_cards,
          data: {
            "card_number": cardNumberController.text.trim(),
            "expiration_month": monthController.text.trim(),
            "expiration_year": yearController.text.trim(),
            "cvv": cvvController.text.trim(),
            "card_holder": cardHolderController.text.trim(),
          });
      snackBar.showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Successfully added card")));
      widget.callBack();
    } catch (e) {
      String error = e.toString();
      print("error cauth $e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Text((error.contains("UNIQUE constraint failed"))
            ? "Card already exists"
            : "Error could not add to database"),
      ));
    }
  }

  void initialize() async {
    //Check if database exists and create it if it does not.
    if (!(await databaseRepository.checkIfDatabaseExists(dtb_user))) {
      await databaseRepository.createDatabaseAndTable(dtb_user, cardTable);
    }
    if (!await databaseRepository.checkIfTableExists(
        tableName: tbl_cards, databaseName: dtb_user)) {
      await databaseRepository.createTable(
          databaseName: dtb_user, tableInfo: cardTable);
    }
    monthFocusNode.addListener(() {
      //Add 0 to month if the length is 1.
      if (!(monthFocusNode.hasFocus) &&
          monthController.text.trim().isNotEmpty) {
        if (monthController.text.trim().length == 1) {
          monthController.text = "0${monthController.text}";
          setState(() {});
        }
      }
    });
  }

  void onCardNumberChange(String? str) {
    //Confirm card and get card info from Paystack.
    if (str != null && str.length >= 6) {
      String string = str;
      if (string.length > 8) {
        string = str.substring(0, 8);
      }

      if (_cardNumberTimer != null) {
        _cardNumberTimer!.cancel();
      }

      _cardNumberTimer = Timer(const Duration(seconds: 1), () async {
        _isCheckingCard = true;
        setState(() {});
        try {
          final response = await _paymentRepository.checkCard(string);

          if (response.statusCode == 200) {
            final decodedResult = await jsonDecode(response.body);
            print("result is $decodedResult");
            _resolveCardBin = ResolveCardBin.fromJson(decodedResult);
            _isCheckingCard = false;
            setState(() {});
          } else {
            _isCheckingCard = false;
            setState(() {});
          }
        } catch (e) {
          //Fail silently.
          debugPrint("***** Error checking card $e ******");
          _isCheckingCard = false;
          setState(() {});
        }
      });
    } else {
      if (_cardNumberTimer != null) {
        _cardNumberTimer!.cancel();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
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
          "Add Card",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                "Card Number",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: smallSpace,
              ),
              Builder(builder: (context) {
                Widget? icon;

                if (_resolveCardBin != null) {
                  if (_resolveCardBin!.data.brand.toLowerCase() == "mastercard") {
                    icon = Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset("assets/images/master_card.png",width: 50,height: 50),
                    );
                  }else if(_resolveCardBin!.data.brand.toLowerCase() == "visa"){
                    //<a href="https://www.flaticon.com/free-icons/visa" title="visa icons">Visa icons created by Freepik - Flaticon</a>
                    icon = Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset("assets/images/visa.png",width: 50,height: 50),
                    );
                  }else if(_resolveCardBin!.data.brand.toLowerCase() == "verve"){
                    icon = Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset("assets/images/verve.png",width: 50,height: 50),
                    );
                  }

                  else{
                    icon = null;
                  }
                }

                return Column(
                  children: [
                    CustomFormField(
                        hint: "545 5784 ****",
                        isPassword: false,
                        trailingIcon: icon,
                        keyboardType: TextInputType.number,
                        textEditingController: cardNumberController,
                        onChanged: onCardNumberChange,
                        formFieldValidator: (str) {
                          return null;
                        }),

                  ],
                );
              }),
              if (_isCheckingCard)
                const Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(),
                ]),
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                "Expiration Date",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: smallSpace,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      hint: "MM",
                      isPassword: false,
                      textEditingController: monthController,
                      focusNode: monthFocusNode,
                    ),
                  ),
                  const SizedBox(
                    width: bigSpace,
                  ),
                  Expanded(
                    child: CustomFormField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      hint: "YY",
                      isPassword: false,
                      textEditingController: yearController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: bigSpace,
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                "CVV",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: smallSpace,
              ),
              CustomFormField(
                  hint: "123",
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  isPassword: false,
                  textEditingController: cvvController,
                  formFieldValidator: (str) {
                    return null;
                  }),
              const SizedBox(
                height: bigSpace,
              ),
              const SizedBox(
                height: bigSpace,
              ),
              Text(
                "Card Holder",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: smallSpace,
              ),
              CustomFormField(
                  hint: "Jessica Maria",
                  isPassword: false,
                  textEditingController: cardHolderController,
                  formFieldValidator: (str) {
                    return null;
                  }),
              const SizedBox(
                height: biggerSpace,
              ),
              MyButton(
                text: "Add Card",
                width: double.infinity,
                height: 50,
                buttonColor: AppColors.blue,
                function: () async {
                  await addCardToDatabase();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
