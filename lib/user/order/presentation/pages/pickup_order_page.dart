import 'package:coffee_app/app.dart';
import 'package:coffee_app/common/loading_button.dart';
import 'package:coffee_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/theme/app_icons.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';
import 'package:coffee_app/user/cart/presentation/cubits/cart_cubit.dart';
import 'package:coffee_app/user/order/presentation/pages/order_placed_page.dart';
import 'package:coffee_app/features/order/presentation/widgets/order_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickupOrderPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const PickupOrderPage({super.key, required this.cartItems});

  @override
  State<PickupOrderPage> createState() => _PickupOrderPageState();
}

class _PickupOrderPageState extends State<PickupOrderPage> {
  final double spacing = 24;
  double total = 0;
  final serviceFee = 1.0;

  Future<void> placeOrder() async {
    context.read<CartCubit>().clearCart();
    await context.read<OrderCubit>().placeOrder(widget.cartItems);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderPlacedPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    for (final cartItem in widget.cartItems) {
      total += (cartItem.item.price * cartItem.quantity);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pick up location',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Jl. Kpg Sutoyo',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const Divider(
          color: AppColors.grey,
        ),

        // item list
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = widget.cartItems[index];
            return OrderItemTile(cartItem: cartItem);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
        ),

        SizedBox(height: spacing),

        // apply discount
        GestureDetector(
          onTap: () => context.showSnackBar('No discount available'),
          child: Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                ImageIcon(
                  AssetImage(AppIcons.discount),
                  color: AppColors.primary,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Apply Discount',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: spacing),

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

        SizedBox(height: spacing),

        LoadingButton(
          text: 'Order',
          callback: placeOrder,
        ),
      ],
    );
  }
}
