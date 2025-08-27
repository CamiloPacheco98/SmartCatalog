import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings.title'.tr())),
      body: Column(children: [Text('settings.title'.tr())]),
    );
  }
}
