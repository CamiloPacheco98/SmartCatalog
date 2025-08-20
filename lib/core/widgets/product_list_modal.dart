import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/features/cart/presentation/models/cart_product_view_model.dart';
import 'package:smart_catalog/core/widgets/product_item.dart';

class ProductListModal extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<CartProductViewModel> products;
  final String buttonName;
  final Function(List<CartProductViewModel>) addProductsToCart;

  const ProductListModal({
    super.key,
    required this.title,
    required this.subtitle,
    required this.products,
    required this.buttonName,
    required this.addProductsToCart,
  });

  @override
  State<ProductListModal> createState() => _ProductListModalState();
}

class _ProductListModalState extends State<ProductListModal> {
  late List<CartProductViewModel> products;

  @override
  void initState() {
    super.initState();
    products = widget.products;
  }

  void increaseQuantity(CartProductViewModel product) {
    setState(() {
      products = products.map((e) {
        if (e.id == product.id) {
          final quantity = int.parse(e.quantity) + 1;
          return e.copyWith(quantity: quantity.toString());
        }
        return e;
      }).toList();
    });
  }

  void decreaseQuantity(CartProductViewModel product) {
    setState(() {
      products = products.map((e) {
        if (e.id == product.id) {
          final quantity = int.parse(e.quantity) - 1;
          return e.copyWith(quantity: quantity.toString());
        }
        return e;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Title
            Text(widget.title, style: context.textTheme.titleMedium),
            const SizedBox(height: 4),

            // Subtitle
            Text(widget.subtitle, style: context.textTheme.bodyMedium),
            const SizedBox(height: 16),

            // List of products
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 20, color: context.colorScheme.secondary),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(
                    product: product,
                    onDecreaseQuantity: (product) => decreaseQuantity(product),
                    onIncreaseQuantity: (product) => increaseQuantity(product),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Main button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Get selected products
                  final selectedProducts = products
                      .where((e) => int.parse(e.quantity) > 0)
                      .toList();

                  // Send selected products to the callback
                  widget.addProductsToCart(selectedProducts);

                  // Close modal
                  context.pop();
                },
                child: Text(
                  widget.buttonName,
                  style: context.textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to display the modal
void showCustomMultiSelectionModal({
  required BuildContext context,
  required String title,
  required String subtitle,
  required List<CartProductViewModel> products,
  required String buttonName,
  required Function(List<CartProductViewModel>) addProductsToCart,
}) {
  showDialog(
    context: context,
    barrierColor: const Color(0x8AFFDABA), // Custom semi-transparent background
    builder: (context) => ProductListModal(
      title: title,
      subtitle: subtitle,
      products: products,
      buttonName: buttonName,
      addProductsToCart: addProductsToCart,
    ),
  );
}
