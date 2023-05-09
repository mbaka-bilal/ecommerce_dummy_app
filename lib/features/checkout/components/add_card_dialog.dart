import 'package:flutter/material.dart';

import '../../../utils/app_images.dart';
import '../../../utils/appstyles.dart';
import '../../../utils/app_utils.dart';


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

