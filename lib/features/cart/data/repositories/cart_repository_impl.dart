import 'package:smart_catalog/core/data/models/cart_product_model.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:hive/hive.dart';

class CartRepositoryImpl extends CartRepository {
  final Box<Map> _cartBox;

  CartRepositoryImpl({required Box<Map> cartBox}) : _cartBox = cartBox;

  @override
  Future<void> increaseQuantityLocalAt(int index) async {
    final productKey = _cartBox.keyAt(index);
    final productMap = _cartBox.get(productKey);
    if (productMap == null) return;
    final productJson = Map<String, dynamic>.from(productMap);
    final product = CartProductModel.fromJson(productJson);
    final updatedProduct = product.copyWith(quantity: product.quantity + 1);
    await _cartBox.put(productKey, updatedProduct.toJson());
  }

  @override
  Future<void> decreaseQuantityLocalAt(int index) async {
    final productKey = _cartBox.keyAt(index);
    final productMap = _cartBox.get(productKey);
    if (productMap == null) return;
    final productJson = Map<String, dynamic>.from(productMap);
    final product = CartProductModel.fromJson(productJson);
    final updatedProduct = product.copyWith(quantity: product.quantity - 1);
    await _cartBox.put(productKey, updatedProduct.toJson());
  }
}
