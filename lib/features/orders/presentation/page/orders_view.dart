import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/constants/asset_paths.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orders.title'.tr(), style: context.textTheme.labelLarge),
      ),
      body: _buildEmptyCart(context),
    );
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
