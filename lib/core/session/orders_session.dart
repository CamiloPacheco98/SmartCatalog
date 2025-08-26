import 'package:smart_catalog/core/domain/entities/order_entity.dart';

class OrdersSession {
  static OrdersSession? _instance;

  factory OrdersSession() {
    _instance ??= OrdersSession._();
    return _instance!;
  }

  OrdersSession._();

  static OrdersSession get instance => _instance ?? OrdersSession._();

  static List<OrderEntity> _orders = [];

  List<OrderEntity> get orders => _orders;

  void initializeOrders(List<OrderEntity> orders) {
    _orders = orders;
  }

  void addOrder(OrderEntity order) {
    _orders.add(order);
  }
}
