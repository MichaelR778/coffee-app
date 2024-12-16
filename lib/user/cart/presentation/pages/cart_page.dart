import 'package:coffee_app/app.dart';
import 'package:coffee_app/common/my_button.dart';
import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/user/cart/presentation/cubits/cart_cubit.dart';
import 'package:coffee_app/user/cart/presentation/cubits/cart_state.dart';
import 'package:coffee_app/user/cart/presentation/widgets/cart_tile.dart';
import 'package:coffee_app/user/order/presentation/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Cart'),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        builder: (context, state) {
          // loading
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded
          else if (state is CartLoaded) {
            final cartItems = state.cartItems;

            // cart is empty
            if (cartItems.isEmpty) {
              return const Center(child: Text('Cart is empty'));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartTile(cartItem: cartItem);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
            );
          }

          // other
          return const Center(child: Text('Oops, something went wrong'));
        },
        listener: (context, state) {
          if (state is CartError) {
            context.showSnackBar(state.message);
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cartItems = state.cartItems;

            if (cartItems.isEmpty) return const SizedBox();

            double total = 0;
            for (final cartItem in cartItems) {
              total += (cartItem.item.price * cartItem.quantity);
            }

            return Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total:'),
                        Text(
                          '\$$total',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: MyButton(
                      text: 'Order Now',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(cartItems: cartItems),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
