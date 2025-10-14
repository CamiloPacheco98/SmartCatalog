import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/core/constants/asset_paths.dart';
import 'package:smart_catalog/core/widgets/product_item.dart';
import 'package:smart_catalog/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/utils/string_formatters.dart';

class CartView extends StatelessWidget {
  final List<CartProductViewModel> products;

  const CartView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart.title'.tr(), style: context.textTheme.labelLarge),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: products.isEmpty ? _buildEmptyCart(context) : _buildCart(context),
      bottomNavigationBar: products.isNotEmpty ? _footer(context) : null,
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetPaths.emptyBag, width: 120, height: 120),
          Text(
            'cart.no_products_title'.tr(),
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'cart.no_products_subtitle'.tr(),
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: Text('cart.no_products_button'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          separatorBuilder: (context, index) =>
              Divider(height: 20, color: context.colorScheme.secondary),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductItem(
              product: product,
              onDecreaseQuantity: (product) =>
                  context.read<CartCubit>().decreaseQuantity(product.id),
              onIncreaseQuantity: (product) =>
                  context.read<CartCubit>().increaseQuantity(product.id),
              onDeleteProduct: (product) =>
                  context.read<CartCubit>().deleteProduct(product),
            );
          },
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    final totalPrice = products.fold<int>(
      0,
      (sum, product) => sum + (product.price * int.parse(product.quantity)),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: context.colorScheme.primary),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cart.total_price'.tr(),
                  style: context.textTheme.labelMedium,
                ),
                Text(
                  totalPrice.formattedPriceWithCurrency,
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CartCubit>().makeOrder();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.onPrimary,
                foregroundColor: context.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text('cart.make_order'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
