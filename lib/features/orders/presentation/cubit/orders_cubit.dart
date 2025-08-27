import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  late final List<OrderEntity> _orders;
  OrdersCubit({required List<OrderEntity> orders}) : super(OrdersInitial()) {
    // TODO: Fix accidental shared reference - OrdersCubit should use immutable state
    // Currently works because _orders shares reference with OrdersSession._orders
    // Should create copy: _orders = List.from(orders) for proper BLoC pattern
    _orders = orders;
    emit(OrdersLoaded(_orders));
  }
}
