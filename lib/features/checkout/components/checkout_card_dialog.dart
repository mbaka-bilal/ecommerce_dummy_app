import 'package:flutter/material.dart';

import '../../../utils/appstyles.dart';
import '../../../widgets/mybutton.dart';

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({
    super.key,
    required this.cardNumber,
    required this.date,
    required this.holdersName,
    required this.cvv,
  });

  final String cardNumber;
  final String date;
  final String holdersName;
  final String cvv;

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final cardTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final holdersNameTextController = TextEditingController();
  final cvvTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Material(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: widget.cardNumber,
                fillColor: AppColors.gray07,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12))),
            controller: cardTextController,
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: widget.date,
                    fillColor: AppColors.gray07,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12))),
                controller: dateTextController,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: widget.cvv,
                    fillColor: AppColors.gray07,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12))),
                controller: cvvTextController,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: widget.holdersName,
                fillColor: AppColors.gray07,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12))),
            controller: holdersNameTextController,
          ),
          const SizedBox(height: 10),
          MyButton(
            text: "Proceed",
            buttonColor: AppColors.blue,
            width: double.infinity,
            height: 50,
            function: () {
              //Pay
            },
          )
        ]),
      ),
    );
  }
}
