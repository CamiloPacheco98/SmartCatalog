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
  late List<CartProductViewModel> initialProducts;

  @override
  void initState() {
    super.initState();
    products = widget.products;
    initialProducts = widget.products;
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

  bool get hasProductsChanged {
    // Check if any product quantity has changed from initial state
    for (int i = 0; i < products.length; i++) {
      if (products[i].quantity != initialProducts[i].quantity) {
        return true;
      }
    }
    return false;
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
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 20, color: context.colorScheme.secondary),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final initialProduct = initialProducts[index];
                  return ProductItem(
                    product: product,
                    onDecreaseQuantity: (product) => decreaseQuantity(product),
                    onIncreaseQuantity: (product) => increaseQuantity(product),
                    minQuantity: initialProduct.quantity.isNotEmpty
                        ? int.parse(initialProduct.quantity)
                        : 0,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Main button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: hasProductsChanged
                    ? () {
                        // Get selected products
                        final selectedProducts = products
                            .where((e) => int.parse(e.quantity) > 0)
                            .toList();

                        // Send selected products to the callback
                        widget.addProductsToCart(selectedProducts);

                        // Close modal
                        context.pop();
                      }
                    : null,
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
