import 'package:flutter/material.dart';

import '../../../repositories/database_repository.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/constants.dart';
import '../../../widgets/mybutton.dart';

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
                var snackBar = ScaffoldMessenger.of(context);
                var navContext = Navigator.of(context);

                try {
                  if (addressController.text.trim().isEmpty ||
                      phoneNumberController.text.trim().isEmpty) {
                    throw EmptyFieldException();
                  }
                  // await databaseRepo.createDatabaseAndTable(dtb_user, addressTable);
                  if (await databaseRepo.checkIfDatabaseExists(dtb_user)) {
                    //Add record to the database
                    await databaseRepo.addRecordToTable(
                        databaseName: dtb_user,
                        tableName: tbl_address,
                        data: {
                          "name": addressController.text,
                          "phone_number": phoneNumberController.text,
                        });
                    navContext.pop();
                    snackBar.showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Successfully added card")));
                  } else {
                    await databaseRepo.createDatabaseAndTable(
                        dtb_user, addressTable);
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
