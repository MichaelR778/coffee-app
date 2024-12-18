import 'package:coffee_app/common/loading_button.dart';
import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderDetailPage extends StatefulWidget {
  final Order order;

  const AdminOrderDetailPage({super.key, required this.order});

  @override
  State<AdminOrderDetailPage> createState() => _AdminOrderDetailPageState();
}

class _AdminOrderDetailPageState extends State<AdminOrderDetailPage> {
  Widget updateButton(OrderStatus status) {
    // pending, accept order
    if (status == OrderStatus.pending) {
      return LoadingButton(
        text: 'Accept Order',
        callback: () async {
          await context.read<OrderCubit>().acceptOrder(widget.order.id);
          if (mounted) Navigator.pop(context);
        },
      );
    }

    // finished brewing, update status to ready
    else if (status == OrderStatus.brewing) {
      return LoadingButton(
        text: 'Ready',
        callback: () async {
          await context.read<OrderCubit>().orderReady(widget.order.id);
          if (mounted) Navigator.pop(context);
        },
      );
    }

    // customer has picked up the order, order finished
    else if (status == OrderStatus.ready) {
      return LoadingButton(
        text: 'Finish Order',
        callback: () async {
          await context.read<OrderCubit>().finishOrder(widget.order.id);
          if (mounted) Navigator.pop(context);
        },
      );
    }

    // order has finished, no need button
    return const SizedBox();
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
          OrderDetail(
            order: widget.order,
            admin: true,
          ),

          const SizedBox(height: 24),

          // button to update order status
          updateButton(widget.order.status),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
