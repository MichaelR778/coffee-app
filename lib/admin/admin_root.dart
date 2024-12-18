import 'package:coffee_app/admin/Item/presentation/pages/item_list_page.dart';
import 'package:coffee_app/admin/order/presentation/pages/finished_order_page.dart';
import 'package:coffee_app/admin/order/presentation/pages/ongoing_order_page.dart';
import 'package:coffee_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRoot extends StatefulWidget {
  const AdminRoot({super.key});

  @override
  State<AdminRoot> createState() => _AdminRootState();
}

class _AdminRootState extends State<AdminRoot> {
  int currIndex = 0;

  final List<Widget> pages = [
    const ItemListPage(),
    const OngoingOrderPage(),
    const FinishedOrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthCubit>().logout(),
        child: const Icon(Icons.logout),
      ),
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
              icon: Icon(Icons.coffee),
              selectedIcon: Icon(
                Icons.coffee,
                color: AppColors.primary,
              ),
              label: 'Menu',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              selectedIcon: Icon(
                Icons.list,
                color: AppColors.primary,
              ),
              label: 'Ongoing',
            ),
            NavigationDestination(
              icon: Icon(Icons.check),
              selectedIcon: Icon(
                Icons.check,
                color: AppColors.primary,
              ),
              label: 'Finished',
            ),
          ],
        ),
      ),
    );
  }
}
