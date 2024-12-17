import 'package:coffee_app/user/order/presentation/widgets/order_list.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ongoing'),
              Tab(text: 'Finished'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderList(finished: false),
            OrderList(finished: true),
          ],
        ),
      ),
    );
  }
}
