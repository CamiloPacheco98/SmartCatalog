class ProductEntity {
  final String id;
  final String name;
  final String desc;
  final int price;
  final int pageIndex;
  final String pageName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String quantity;
  const ProductEntity({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.pageIndex,
    required this.pageName,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
  });
}
