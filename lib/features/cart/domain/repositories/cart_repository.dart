abstract class CartRepository {
  Future<void> increaseQuantityLocalAt(int index);
  Future<void> decreaseQuantityLocalAt(int index);
}
