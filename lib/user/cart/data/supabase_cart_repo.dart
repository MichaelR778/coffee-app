import 'package:coffee_app/main.dart';
import 'package:coffee_app/user/cart/domain/repos/cart_repo.dart';

class SupabaseCartRepo implements CartRepo {
  @override
  Future<void> addToCart(String userId, int itemId) async {
    try {
      final existingItem = await supabase
          .from('cart')
          .select('id, quantity')
          .eq('user_id', userId)
          .eq('item_id', itemId)
          .maybeSingle();

      // item not in cart, insert new row
      if (existingItem == null) {
        await supabase.from('cart').insert({
          'user_id': userId,
          'item_id': itemId,
          'quantity': 1,
        });
      }

      // add quantity
      else {
        final newQty = (existingItem['quantity'] as int) + 1;
        await supabase
            .from('cart')
            .update({'quantity': newQty})
            .eq('user_id', userId)
            .eq('item_id', itemId);
      }
    } catch (e) {
      throw Exception('Failed to access cart (add/increase): $e');
    }
  }

  @override
  Future<void> subtractFromCart(String userId, int itemId) async {
    try {
      final existingItem = await supabase
          .from('cart')
          .select('id, quantity')
          .eq('user_id', userId)
          .eq('item_id', itemId)
          .maybeSingle();

      // item not found
      if (existingItem == null) throw Exception('Item not found in cart');

      // subtract quantity
      final newQty = (existingItem['quantity'] as int) - 1;

      // newQty is 0, delete row
      if (newQty == 0) {
        await supabase
            .from('cart')
            .delete()
            .eq('user_id', userId)
            .eq('item_id', itemId);
      }

      // update qty
      else {
        await supabase
            .from('cart')
            .update({'quantity': newQty})
            .eq('user_id', userId)
            .eq('item_id', itemId);
      }
    } catch (e) {
      throw Exception('Failed to access cart (remove/subtract): $e');
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      await supabase.from('cart').delete().eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getCartStream(String userId) {
    return supabase
        .from('cart')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: true);
  }
}
