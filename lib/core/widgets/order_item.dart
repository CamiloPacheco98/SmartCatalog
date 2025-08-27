import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/domain/entities/order_entity.dart';

class OrderInfoSection extends StatelessWidget {
  final OrderEntity order;
  final String formattedDate;

  const OrderInfoSection({
    super.key,
    required this.order,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
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
            'order_detail.order_info'.tr(),
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(context, 'order_detail.order_id'.tr(), order.id),
          const SizedBox(height: 12),
          _buildInfoRow(context, 'order_detail.order_date'.tr(), formattedDate),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'order_detail.order_status'.tr(),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: _getStatusColor(context, order.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.end,
          ),
        ),
      ],
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
}