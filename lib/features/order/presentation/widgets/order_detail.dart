import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_item_tile.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_status_timeline.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final Order order;
  final bool admin;

  const OrderDetail({
    super.key,
    required this.order,
    this.admin = false,
  });

  @override
  Widget build(BuildContext context) {
    double total = 0;
    const serviceFee = 1.0;

    for (final cartItem in order.cartItems) {
      total += cartItem.quantity * cartItem.item.price;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // status timeline
        OrderStatusTimeline(
          order: order,
          admin: admin,
        ),

        const SizedBox(height: 24),

        // items
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.cartItems.length,
          itemBuilder: (context, index) {
            return OrderItemTile(cartItem: order.cartItems[index]);
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Service Fee',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              '\$ $serviceFee',
              style: TextStyle(
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
      ],
    );
  }
}
