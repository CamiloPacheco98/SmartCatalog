import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/core/constants/asset_paths.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetPaths.logo, width: 100, height: 100),
            SizedBox(height: 20),
            Text('app_name'.tr(), style: context.textTheme.titleLarge),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
