import 'package:coffee_app/features/order/domain/entities/order.dart';

abstract class OrderRepo {
  Future<void> placeOrder(Order order);
  Stream<List<Order>> getUserOrderStream(String userId);
  Stream<List<Order>> getAllOrderStream();
}
