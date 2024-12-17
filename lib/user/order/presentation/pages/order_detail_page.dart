import 'package:coffee_app/common/loading_button.dart';
import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_item_tile.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_status_timeline.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  double total = 0;
  final serviceFee = 1.0;

  Future<void> cancelOrder() async {
    await context.read<OrderCubit>().cancelOrder(widget.order.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    for (final cartItem in widget.order.cartItems) {
      total += cartItem.quantity * cartItem.item.price;
    }

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
          // status timeline
          OrderStatusTimeline(order: widget.order),

          const SizedBox(height: 24),

          // items
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.order.cartItems.length,
            itemBuilder: (context, index) {
              return OrderItemTile(cartItem: widget.order.cartItems[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),

          const SizedBox(height: 24),

          // payment summary
          const Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '\$ $total',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service Fee',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '\$ $serviceFee',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Divider(
            color: AppColors.grey,
          ),

          // total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '\$ ${total + serviceFee}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

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
