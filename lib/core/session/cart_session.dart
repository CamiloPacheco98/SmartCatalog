import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

class CartSession {
  static CartSession? _instance;
  List<CartProductViewModel> _products = [];

  CartSession._();

  static CartSession get instance {
    _instance ??= CartSession._();
    return _instance!;
  }

  List<CartProductViewModel> get cartProducts => _products;

  void initializeProducts(List<CartProductViewModel> products) {
    _products = products;
  }

  void addProductList(List<CartProductViewModel> productList) {
    for (var product in productList) {
      addProduct(product);
    }
  }

  void addProduct(CartProductViewModel product) {
    final bool exists = _products.any((p) => p.id == product.id);
    if (exists) {
      _products = _products.map((p) {
        if (p.id == product.id) {
          return p.copyWith(quantity: product.quantity);
        }
        return p;
      }).toList();
    } else {
      _products.add(product);
    }
  }

  void removeProduct(CartProductViewModel product) {
    _products.remove(product);
  }

  void clearCart() {
    _products.clear();
  }
}
