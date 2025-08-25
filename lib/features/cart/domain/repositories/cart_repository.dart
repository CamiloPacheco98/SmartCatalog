abstract class CartRepository {
  Future<void> increaseQuantityLocalAt(int index);
  Future<void> decreaseQuantityLocalAt(int index);
  Future<void> increaseQuantity(String productId);
  Future<void> decreaseQuantity(String productId);
}
