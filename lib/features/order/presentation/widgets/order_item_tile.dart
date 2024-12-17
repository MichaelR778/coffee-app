import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final CartItem cartItem;

  const OrderItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final item = cartItem.item;
    return Row(
      children: [
        // item image
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox();
              },
            ),
          ),
        ),

        const SizedBox(width: 10),

        // item name and price
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(fontSize: 16),
              ),
              Text('\$ ${item.price}'),
            ],
          ),
        ),

        // qty
        Expanded(
          child: Center(
            child: Text(cartItem.quantity.toString()),
          ),
        ),
      ],
    );
  }
}
