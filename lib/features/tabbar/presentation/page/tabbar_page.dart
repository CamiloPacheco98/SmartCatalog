import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/features/tabbar/presentation/tabbar.dart';

class TabbarPage extends StatelessWidget {
  final List<String> imageUrls;
  const TabbarPage({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabbarCubit(),
      child: BlocBuilder<TabbarCubit, int>(
        builder: (context, currentIndex) {
          return TabbarView(currentIndex: currentIndex, imageUrls: imageUrls);
        },
      ),
    );
  }
}
