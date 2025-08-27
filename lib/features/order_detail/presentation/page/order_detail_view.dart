import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/core/domain/entities/cart_products_entity.dart';
import 'package:smart_catalog/core/widgets/order_item.dart';

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

          _buildProductsSection(context, order.products),
          const SizedBox(height: 24),

          _buildSummarySection(context, totalProducts),
        ],
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context,
    List<CartProductEntity> products,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order_detail.products_list'.tr(),
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductItem(context, product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, CartProductEntity product) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'order_detail.product_code'.tr(args: [product.id]),
            style: context.textTheme.bodyLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'order_detail.quantity'.tr(args: [product.quantity.toString()]),
            style: context.textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context, int totalProducts) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'order_detail.total_products'.tr(),
            style: context.textTheme.titleMedium,
          ),
          Text(totalProducts.toString(), style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}
