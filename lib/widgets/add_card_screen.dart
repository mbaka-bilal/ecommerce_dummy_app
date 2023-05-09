import 'package:ecommerce_dummy_app/repositories/database_repository.dart';
import 'package:flutter/material.dart';

import '../utils/app_utils.dart';
import '../utils/appstyles.dart';
import '../utils/constants.dart';
import '../widgets/my_form.dart';
import '../widgets/mybutton.dart';
import 'custom_form.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardNumberController = TextEditingController();
    final monthController = TextEditingController();
    final yearController = TextEditingController();
    final cvvController = TextEditingController();
    final cardHolderController = TextEditingController();
    final databaseRepository = DatabaseRepository();

    final monthFocusNode = FocusNode();

    monthFocusNode.addListener(() {
      if (!(monthFocusNode.hasFocus) &&
          monthController.text.trim().isNotEmpty) {
        if (monthController.text.trim().length == 1) {
          monthController.text = "0${monthController.text}";
        }
      }
    });

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
              CustomFormField(
                  hint: "545 5784 ****",
                  isPassword: false,
                  keyboardType: TextInputType.number,
                  textEditingController: cardNumberController,
                  formFieldValidator: (str) {
                    return null;
                  }),
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
                  //TODO move all this to a database called userInfo
                  var snackBar = ScaffoldMessenger.of(context);

                  try {
                    if (cardHolderController.text.trim().isEmpty ||
                        monthController.text.trim().isEmpty ||
                        yearController.text.trim().isEmpty ||
                        cvvController.text.trim().isEmpty ||
                        cardNumberController.text.trim().isEmpty) {
                      throw EmptyFieldException();
                    }
                    if (await databaseRepository
                        .checkIfDatabaseExists(dtb_user)) {
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
                    } else {
                      await databaseRepository.createDatabaseAndTable(
                          dtb_user, cardTable);

                    }
                  } catch (e) {
                    String error = e.toString();
                    print ("error cauth $e");

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text((error.contains("UNIQUE constraint failed"))
                          ? "Card already exists"
                          : "Error could not add to database"),
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
