import 'package:flutter/material.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatelessWidget {
  final List<CartProductViewModel> products;

  const CartView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: products.isEmpty
          ? const Center(child: Text('No products in cart'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => Text(products[index].id),
            ),
    );
  }
}
