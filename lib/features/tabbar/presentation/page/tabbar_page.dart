import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_catalog/features/tabbar/presentation/tabbar.dart';

class TabbarPage extends StatelessWidget {
  const TabbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabbarCubit(),
      child: BlocBuilder<TabbarCubit, int>(
        builder: (context, currentIndex) {
          return TabbarView(currentIndex: currentIndex);
        },
      ),
    );
  }
}
