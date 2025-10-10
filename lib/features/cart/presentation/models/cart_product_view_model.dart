import 'package:smart_catalog/core/domain/entities/product_entity.dart';

class CartProductViewModel {
  final String id;
  final String name;
  final String desc;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String pageName;
  final int pageIndex;
  final String quantity;

  CartProductViewModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
    required this.pageName,
    required this.pageIndex,
  });

  factory CartProductViewModel.fromEntity(ProductEntity entity) {
    return CartProductViewModel(
      id: entity.id,
      name: entity.name,
      desc: entity.desc,
      price: entity.price,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      quantity: entity.quantity,
      pageName: entity.pageName,
      pageIndex: entity.pageIndex,
    );
  }

  CartProductViewModel copyWith({
    String? name,
    String? desc,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? quantity,
    String? pageName,
    int? pageIndex,
  }) {
    return CartProductViewModel(
      id: id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      quantity: quantity ?? this.quantity,
      pageName: pageName ?? this.pageName,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
