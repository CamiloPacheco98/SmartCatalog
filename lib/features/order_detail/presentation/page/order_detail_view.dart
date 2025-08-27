import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/features/order_detail/presentation/widgets/order_info_section.dart';
import 'package:smart_catalog/features/order_detail/presentation/widgets/order_products_section.dart';
import 'package:smart_catalog/features/order_detail/presentation/widgets/order_summary_section.dart';

class OrderDetailView extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'order_detail.title'.tr(),
          style: context.textTheme.labelLarge,
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _buildOrderDetail(context, order),
    );
  }

  Widget _buildOrderDetail(BuildContext context, OrderEntity order) {
    final formattedDate = DateFormat(
      'dd MMMM yyyy, HH:mm',
      context.locale.languageCode,
    ).format(order.createdAt);

    final totalProducts = order.products.fold<int>(
      0,
      (sum, product) => sum + product.quantity,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderInfoSection(order: order, formattedDate: formattedDate),
          const SizedBox(height: 24),

          OrderProductsSection(products: order.products),
          const SizedBox(height: 24),

          OrderSummarySection(totalProducts: totalProducts),
        ],
      ),
    );
  }
}
