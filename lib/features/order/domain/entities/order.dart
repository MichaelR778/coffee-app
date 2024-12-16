import 'package:coffee_app/features/item/domain/entities/item.dart';
import 'package:coffee_app/user/cart/domain/entities/cart_item.dart';

class Order {
  final int id;
  final String userId;
  final List<CartItem> cartItems;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? readyAt;
  final DateTime? finishedAt;

  Order({
    required this.id,
    required this.userId,
    required this.cartItems,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    this.readyAt,
    this.finishedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'user_id': userId,
      'cart_items': cartItems
          .map((cartItem) => {
                'item': cartItem.item.toJson(),
                'quantity': cartItem.quantity,
              })
          .toList(),
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'accepted_at': acceptedAt?.toIso8601String(),
      'ready_at': readyAt?.toIso8601String(),
      'finished_at': finishedAt?.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      cartItems: (json['cart_items'] as List)
          .map((cartItemJson) => CartItem(
              item: Item.fromJson(cartItemJson['item']),
              quantity: cartItemJson['quantity']))
          .toList(),
      status: OrderStatus.values.firstWhere((e) => e.name == json['status']),
      createdAt: DateTime.parse(json['created_at']),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'])
          : null,
      readyAt:
          json['ready_at'] != null ? DateTime.parse(json['ready_at']) : null,
      finishedAt: json['finished_at'] != null
          ? DateTime.parse(json['finished_at'])
          : null,
    );
  }
}

enum OrderStatus {
  pending,
  brewing,
  ready,
  finished,
}
