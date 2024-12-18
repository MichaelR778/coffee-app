import 'package:coffee_app/admin/order/presentation/widgets/admin_order_list.dart';
import 'package:flutter/material.dart';

class FinishedOrderPage extends StatelessWidget {
  const FinishedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Orders'),
      ),
      body: const AdminOrderList(finished: true),
    );
  }
}
