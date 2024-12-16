import 'package:coffee_app/features/item/domain/entities/item.dart';

class CartItem {
  final Item item;
  final int quantity;

  CartItem({
    required this.item,
    required this.quantity,
  });
}
