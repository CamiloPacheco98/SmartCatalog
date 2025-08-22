import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CartProductEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int quantity;

  CartProductEntity({required this.id, required this.quantity}) : super();
}
