import 'package:coffee_app/theme/app_colors.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';
import 'package:coffee_app/user/order/presentation/pages/pickup_order_page.dart';
import 'package:coffee_app/user/order/presentation/widgets/order_type_button.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const OrderPage({super.key, required this.cartItems});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final double spacing = 24;
  int selectedIndex = 0;

  late final List<Widget> pages = [
    PickupOrderPage(cartItems: widget.cartItems),
    const Align(
      child: Text(
        'Sorry this service is not available',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Order'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: spacing),
        children: [
          // buttons to choose pickup/deliver order
          Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OrderTypeButton(
                    text: 'Pick Up',
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: OrderTypeButton(
                    text: 'Deliver',
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spacing),

          // order page main content
          pages[selectedIndex],
        ],
      ),
    );
  }
}
