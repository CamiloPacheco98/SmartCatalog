import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/features/tabbar/presentation/tabbar.dart';

class TabbarView extends StatelessWidget {
  const TabbarView({
    super.key,
    required this.currentIndex,
    required this.imageUrls,
  });
  final int currentIndex;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Center(child: CatalogPage(imageUrls: imageUrls)),
      Center(child: OrdersPage()),
      Center(child: SettingsPage()),
    ];
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.read<TabbarCubit>().changeTab(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: "tabbar.catalog".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "tabbar.orders".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "tabbar.profile".tr(),
          ),
        ],
      ),
    );
  }
}
