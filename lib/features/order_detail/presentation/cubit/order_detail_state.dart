part of 'order_detail_cubit.dart';

@immutable
sealed class OrderDetailState {}

final class OrderDetailInitial extends OrderDetailState {}

final class OrderDetailLoaded extends OrderDetailState {
  final OrderEntity order;
  
  OrderDetailLoaded(this.order);
}
