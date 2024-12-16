import 'package:coffee_app/admin/Item/item_list_page.dart';
import 'package:coffee_app/features/auth/presentation/cubits/auth_cubit.dart';
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
    const Center(child: Text('Ongoing Orders')),
    const Center(child: Text('Finished Orders')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthCubit>().logout(),
      ),
      body: pages[currIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: currIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.fastfood),
              label: 'Menu',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Ongoing',
            ),
            NavigationDestination(
              icon: Icon(Icons.check),
              label: 'Finished',
            ),
          ],
        ),
      ),
    );
  }
}
