import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';
import 'package:coffee_app/user/cart/presentation/cubits/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;

  const CartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final item = cartItem.item;
    return Row(
      children: [
        // item image
        Container(
          width: 80,
          height: 80,
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
          flex: 2,
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
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: IconButton.filled(
                  onPressed: () {
                    context.read<CartCubit>().subtractFromCart(item.id);
                  },
                  icon: const Icon(Icons.remove),
                  iconSize: 10,
                ),
              ),
              Expanded(
                child: Text(
                  cartItem.quantity.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: IconButton.filled(
                  onPressed: () {
                    context.read<CartCubit>().addToCart(item.id);
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
