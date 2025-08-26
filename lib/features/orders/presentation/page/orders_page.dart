import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/session/orders_session.dart';
import 'package:smart_catalog/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:smart_catalog/features/orders/presentation/page/orders_view.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(orders: OrdersSession.instance.orders),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return OrdersView(orders: state is OrdersLoaded ? state.orders : []);
        },
      ),
    );
  }
}
