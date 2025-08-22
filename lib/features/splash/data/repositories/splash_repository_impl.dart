import 'package:hive/hive.dart';
import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  final Box<CartProductEntity> _cartBox;

  SplashRepositoryImpl({required Box<CartProductEntity> cartBox})
    : _cartBox = cartBox;

  @override
  Future<List<CartProductEntity>> getLocalCartProducts() async {
    return _cartBox.values.toList();
  }
}
