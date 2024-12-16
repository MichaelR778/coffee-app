abstract class CartRepo {
  Future<void> addToCart(String userId, int itemId);
  Future<void> subtractFromCart(String userId, int itemId);
  Future<void> clearCart(String userId);
  Stream<List<Map<String, dynamic>>> getCartStream(String userId);
}
