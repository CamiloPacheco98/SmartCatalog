import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/constants/asset_paths.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';

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
      body: products.isEmpty
          ? Padding(
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
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => Text(products[index].id),
            ),
    );
  }
}
