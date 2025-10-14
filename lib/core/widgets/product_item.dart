import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/core/utils/string_formatters.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onDecreaseQuantity,
    required this.onIncreaseQuantity,
    this.onDeleteProduct,
    this.minQuantity = 1,
  });
  final CartProductViewModel product;
  final Function(CartProductViewModel) onDecreaseQuantity;
  final Function(CartProductViewModel) onIncreaseQuantity;
  final Function(CartProductViewModel)? onDeleteProduct;
  final int minQuantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'cart.product_code'.tr(args: [product.id]),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                product.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                product.price.formattedPriceWithCurrency,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Quantity controls
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: int.parse(product.quantity) > minQuantity
                    ? () => onDecreaseQuantity(product)
                    : null,
                icon: Icon(
                  Icons.remove,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  product.quantity,
                  style: context.textTheme.bodyLarge,
                ),
              ),
              IconButton(
                onPressed: () => onIncreaseQuantity(product),
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        if (onDeleteProduct != null) ...[
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => onDeleteProduct!(product),
            child: Icon(
              Icons.delete_rounded,
              color: context.colorScheme.error,
              size: 25,
            ),
          ),
        ],
      ],
    );
  }
}
