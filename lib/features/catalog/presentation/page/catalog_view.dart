import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/utils/env_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_catalog/features/catalog/presentation/catalog.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  static const int _totalPages = 125;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo 2025 c8', style: context.textTheme.labelLarge),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CatalogCubit>().getProductsCodeByPage(_currentPage + 1);
        },
        child: const Icon(Icons.add_shopping_cart_sharp),
      ),
      body: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: _totalPages,
            itemBuilder: (context, index, realIndex) {
              return CachedNetworkImage(
                imageUrl: EnvManager.imageBaseUrl.replaceAll(
                  '{page}',
                  '${index + 1}',
                ),
                fit: BoxFit.cover,
                memCacheHeight: 1000,
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
                '${_currentPage + 1} / $_totalPages',
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
