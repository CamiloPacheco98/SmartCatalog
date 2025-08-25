import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onDecreaseQuantity,
    required this.onIncreaseQuantity,
  });
  final CartProductViewModel product;
  final Function(CartProductViewModel) onDecreaseQuantity;
  final Function(CartProductViewModel) onIncreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product info
        Expanded(
          child: Text(
            'cart.product_code'.tr(args: [product.id]),
            style: context.textTheme.bodyLarge,
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
                onPressed: int.parse(product.quantity) > 0 
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
      ],
    );
  }
}
