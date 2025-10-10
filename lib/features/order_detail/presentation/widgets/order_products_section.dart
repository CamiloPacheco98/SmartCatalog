import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/domain/entities/product_entity.dart';

class OrderProductsSection extends StatelessWidget {
  final List<ProductEntity> products;

  const OrderProductsSection({super.key, required this.products});

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

  Widget _buildProductItem(BuildContext context, ProductEntity product) {
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
}
