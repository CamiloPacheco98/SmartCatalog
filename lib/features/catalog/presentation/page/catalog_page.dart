import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/utils/env_manager.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  static const int _totalPages = 125;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo 2025 c8', style: context.textTheme.labelLarge),
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
