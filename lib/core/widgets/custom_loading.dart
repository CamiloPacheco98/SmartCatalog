import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_catalog/core/constants/asset_paths.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x8AFFDABA),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              AssetPaths.shoppingLoader,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
