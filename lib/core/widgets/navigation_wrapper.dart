import 'package:flutter/material.dart';
import 'package:smart_catalog/core/utils/navigation_service.dart';

/// A wrapper widget that keeps the NavigationService context updated
class NavigationWrapper extends StatefulWidget {
  final Widget child;

  const NavigationWrapper({
    super.key,
    required this.child,
  });

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the NavigationService context whenever the widget tree changes
    NavigationService().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
