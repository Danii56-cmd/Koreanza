import 'package:flutter/material.dart';

class CustomPopScope extends StatelessWidget {
  const CustomPopScope({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
      },
      child: child,
    );
  }
}
