import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_catalog/features/catalog/presentation/catalog.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo 2025 c9', style: context.textTheme.labelLarge),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CatalogCubit>().navigateToCart();
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CatalogCubit>().getProductsCodeByPage(_currentPage);
        },
        child: const Icon(Icons.add_shopping_cart_sharp),
      ),
      body: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return CachedNetworkImage(
                imageUrl: widget.imageUrls[index],
                fit: BoxFit.cover,
                memCacheHeight: 1000,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                if (index != _currentPage) {
                  setState(() => _currentPage = index);
                }
              },
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentPage + 1} / ${widget.imageUrls.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
