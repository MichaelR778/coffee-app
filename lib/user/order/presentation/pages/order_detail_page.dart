import 'package:coffee_app/common/loading_button.dart';
import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Future<void> cancelOrder() async {
    await context.read<OrderCubit>().cancelOrder(widget.order.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Order Detail'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          OrderDetail(order: widget.order),

          const SizedBox(height: 24),

          // cancel button
          widget.order.status == OrderStatus.pending
              ? LoadingButton(
                  text: 'Cancel',
                  callback: cancelOrder,
                )
              : const SizedBox(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
