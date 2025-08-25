import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('orders.title'.tr())));
  }
}
