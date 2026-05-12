import 'package:flutter/material.dart';

class CustomPopScope extends StatelessWidget {
  const CustomPopScope({
    super.key,
    required this.child,
    this.onBackPop,
    this.canPop = true,
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
        } else {
          Navigator.pop(context);
        }
      },
      child: child,
    );
  }
}
