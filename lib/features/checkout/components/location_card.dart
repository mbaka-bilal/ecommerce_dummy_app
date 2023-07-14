import 'package:flutter/material.dart';

import '../../../utils/appstyles.dart';

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
            // Expanded(
            //     flex: 1,
            //     child: InkWell(
            //       onTap: () {
            //         //Show options to edit and delete this item.
            //       },
            //       child: Row(
            //           children: List.generate(
            //         3,
            //         (index) => const Padding(
            //           padding: EdgeInsets.only(right: 5),
            //           // padding: const EdgeInsets.all(8.0),
            //           child: CircleAvatar(
            //             radius: 3,
            //             backgroundColor: AppColors.gray04,
            //           ),
            //         ),
            //       )),
            //     ))
          ],
        ),
      ),
    );
  }
}
