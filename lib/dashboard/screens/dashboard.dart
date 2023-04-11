import 'package:ecommerce_dummy_app/profile/screens/user_profile.dart';
import 'package:ecommerce_dummy_app/utils/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../home/screens/home.dart';
import '../../utils/app_images.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _index = 0;
  final List<Widget> _screens = [
    const Home(),
    const CartScreen(),
    const NotificationScreen(),
    const UserProfile(),
  ];

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required bool isActive, required Widget icon}) {
    return BottomNavigationBarItem(
        icon: Container(
            decoration: (isActive)
                ? BoxDecoration(
                    color: AppColors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(26))
                : null,
            // color: AppColors.blue,
            width: double.infinity,
            // height: 30,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: icon),
        label: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          // selectedItemColor: AppColors.blue,
          // unselectedItemColor: AppColors.gray03,
          enableFeedback: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: [
            _bottomNavigationBarItem(
                isActive: (_index == 0) ? true : false,
                icon: SvgPicture.asset(AppImages.menu,
                    colorFilter: ColorFilter.mode(
                        (_index == 0) ? AppColors.blue : AppColors.gray04,
                        BlendMode.srcIn))),
            _bottomNavigationBarItem(
                isActive: (_index == 1) ? true : false,
                icon: SvgPicture.asset(AppImages.shoppingBag,
                    colorFilter: ColorFilter.mode(
                        (_index == 1) ? AppColors.blue : AppColors.gray04,
                        BlendMode.srcIn))),
            _bottomNavigationBarItem(
                isActive: (_index == 2) ? true : false,
                icon: SvgPicture.asset(
                  AppImages.notificationsBell,
                  colorFilter: ColorFilter.mode(
                      (_index == 2) ? AppColors.blue : AppColors.gray04,
                      BlendMode.srcIn),
                )),
            _bottomNavigationBarItem(
                isActive: (_index == 3) ? true : false,
                icon: SvgPicture.asset(AppImages.person,
                    colorFilter: ColorFilter.mode(
                        (_index == 3) ? AppColors.blue : AppColors.gray04,
                        BlendMode.srcIn))),
          ]),
      body: _screens[_index]
    );
  }
}



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Cart"),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Notifications"),
      ),
    );
  }
}
