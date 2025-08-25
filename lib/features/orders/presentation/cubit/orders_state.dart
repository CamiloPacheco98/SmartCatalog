part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  OrdersLoaded(this.orders);
}
