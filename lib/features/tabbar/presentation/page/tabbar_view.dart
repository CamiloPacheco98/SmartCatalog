import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_catalog/features/catalog/presentation/page/catalog_page.dart';
import 'package:smart_catalog/features/orders/presentation/page/orders_page.dart';
import 'package:smart_catalog/features/tabbar/presentation/tabbar.dart';

class TabbarView extends StatelessWidget {
  TabbarView({super.key, required this.currentIndex});
  final int currentIndex;

  //TODO: replace with pages
  final _pages = [
    Center(child: CatalogPage()),
    Center(child: OrdersPage()),
    Center(child: Text("Perfil")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
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
