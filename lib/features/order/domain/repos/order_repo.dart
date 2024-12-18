import 'package:coffee_app/features/order/domain/entities/order.dart';

abstract class OrderRepo {
  Future<void> placeOrder(Order order);
  Stream<List<Order>> getUserOrderStream(String userId);
  Stream<List<Order>> getAllOrderStream();
  Future<void> cancelOrder(int orderId);

  // update status by admin / coffee store worker
  Future<void> acceptOrder(int orderId);
  Future<void> orderReady(int orderId);
  Future<void> finishOrder(int orderId);
}
