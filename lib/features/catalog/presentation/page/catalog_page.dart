import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';
import 'package:smart_catalog/core/utils/env_manager.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo 2025 c8', style: context.textTheme.labelLarge),
      ),
      body: CarouselSlider.builder(
        itemCount: 125,
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
        options: CarouselOptions(height: double.infinity, viewportFraction: 1),
      ),
    );
  }
}
