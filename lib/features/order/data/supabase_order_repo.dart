import 'package:coffee_app/features/order/domain/entities/order.dart';
import 'package:coffee_app/features/order/domain/repos/order_repo.dart';
import 'package:coffee_app/main.dart';

class SupabaseOrderRepo implements OrderRepo {
  @override
  Future<void> placeOrder(Order order) async {
    try {
      await supabase.from('orders').insert(order.toJson());
    } catch (e) {
      throw Exception('Error placing order: $e');
    }
  }

  @override
  Stream<List<Order>> getUserOrderStream(String userId) {
    return supabase
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: true)
        .map((jsons) => jsons.map((json) => Order.fromJson(json)).toList());
  }

  @override
  Stream<List<Order>> getAllOrderStream() {
    return supabase
        .from('orders')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((jsons) => jsons.map((json) => Order.fromJson(json)).toList());
  }
}