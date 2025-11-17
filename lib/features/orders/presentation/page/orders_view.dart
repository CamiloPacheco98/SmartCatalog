import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/constants/asset_paths.dart';
import 'package:smart_catalog/app/routes/app_path.dart';
import 'package:smart_catalog/core/utils/string_formatters.dart';
import 'package:go_router/go_router.dart';

class OrdersView extends StatelessWidget {
  final List<OrderEntity> orders; //TODO: create order view model
  const OrdersView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orders.title'.tr(), style: context.textTheme.labelLarge),
      ),
      body: orders.isEmpty ? _buildEmptyCart(context) : _buildOrders(context),
    );
  }

  Widget _buildOrders(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              context.pushNamed(AppPaths.orderDetail, extra: orders[index]),
          child: _buildOrderCard(context, orders[index]),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderEntity order) {
    final totalWithDiscount =
        order.total - (order.total * order.discountPercentage / 100).toInt();
    final formattedDate = DateFormat(
      'dd MMMM yyyy',
      context.locale.languageCode,
    ).format(order.createdAt);
    final totalProducts = order.products.fold<int>(
      0,
      (sum, product) => sum + int.parse(product.quantity),
    );

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    formattedDate,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$totalProducts ${"orders.products".tr()}',
                    style: context.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${"orders.order_id".tr()}: ${order.id}',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${"orders.discount_percentage".tr()}: ${order.discountPercentage}%',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              totalWithDiscount.toString().formattedPriceWithCurrency,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getStatusColor(context, order.status),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _getStatusText(order.status),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: _getStatusColor(context, order.status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return context.colorScheme.primary;
      case OrderStatus.completed:
        return context.colorScheme.primary;
      case OrderStatus.cancelled:
        return context.colorScheme.error;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'orders.status.pending'.tr();
      case OrderStatus.completed:
        return 'orders.status.completed'.tr();
      case OrderStatus.cancelled:
        return 'orders.status.cancelled'.tr();
    }
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetPaths.emptyOrders, width: 150, height: 150),
          Text(
            'orders.no_orders_title'.tr(),
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'orders.no_orders_subtitle'.tr(),
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
