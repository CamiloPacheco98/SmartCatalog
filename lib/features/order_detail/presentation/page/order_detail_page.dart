import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/features/order_detail/presentation/order_detail.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailCubit(order),
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoaded) {
            return OrderDetailView(order: state.order);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
