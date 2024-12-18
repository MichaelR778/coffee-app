import 'package:coffee_app/admin/order/presentation/widgets/admin_order_list.dart';
import 'package:flutter/material.dart';

class OngoingOrderPage extends StatelessWidget {
  const OngoingOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongoing Orders'),
      ),
      body: const AdminOrderList(finished: false),
    );
  }
}
