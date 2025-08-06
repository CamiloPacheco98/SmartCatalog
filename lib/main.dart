import 'package:flutter/material.dart';
import 'package:smart_catalog/app/routes/app_router.dart';
import 'package:smart_catalog/core/theme/app_theme.dart';

void main() {
  runApp(const SmartCatalogApp());
}

class SmartCatalogApp extends StatelessWidget {
  const SmartCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smart Catalog',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
