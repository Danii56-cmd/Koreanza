import 'package:flutter/material.dart';
import 'package:koreanza/services/tab_navigation_service.dart';

class CustomPopScope extends StatelessWidget {
  const CustomPopScope({
    super.key,
    required this.child,
    this.onBackPop,
    this.canPop = false,
  });

  final Widget child;
  final VoidCallback? onBackPop;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (onBackPop != null) {
          onBackPop!();
          return;
        }
        final bool isNested = Navigator.of(context).canPop();

        if (isNested) {
          Navigator.of(context).pop();
        } else {
          TabNavigationService.instance.goToHome();
        }
      },
      child: child,
    );
  }
}
