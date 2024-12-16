import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/theme/app_icons.dart';
import 'package:coffee_app/user/home/presentation/pages/home_page.dart';
import 'package:coffee_app/user/order/presentation/pages/order_list_page.dart';
import 'package:coffee_app/user/profile/profile_page.dart';
import 'package:flutter/material.dart';

class UserRoot extends StatefulWidget {
  const UserRoot({super.key});

  @override
  State<UserRoot> createState() => _UserRootState();
}

class _UserRootState extends State<UserRoot> {
  int currIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const Center(child: Text('Page')),
    const OrderListPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: NavigationBar(
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: currIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: ImageIcon(AssetImage(AppIcons.home)),
              selectedIcon: ImageIcon(
                AssetImage(AppIcons.homeSelected),
                color: AppColors.primary,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: ImageIcon(AssetImage(AppIcons.heart)),
              selectedIcon: ImageIcon(
                AssetImage(AppIcons.heartSelected),
                color: AppColors.primary,
              ),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: ImageIcon(AssetImage(AppIcons.order)),
              selectedIcon: ImageIcon(
                AssetImage(AppIcons.orderSelected),
                color: AppColors.primary,
              ),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: ImageIcon(AssetImage(AppIcons.user)),
              selectedIcon: ImageIcon(
                AssetImage(AppIcons.userSelected),
                color: AppColors.primary,
              ),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
