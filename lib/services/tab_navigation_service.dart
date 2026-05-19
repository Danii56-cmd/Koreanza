import 'package:flutter/material.dart';

/// Singleton service that keeps the bottom-nav tab in sync across the app
/// (drawer, back navigation, direct taps) without BuildContext or prop-drilling.
class TabNavigationService {
  TabNavigationService._();

  static final TabNavigationService instance = TabNavigationService._();

  final ValueNotifier<int> tabNotifier = ValueNotifier(0);
  int get currentIndex => tabNotifier.value;

  // Internal callbacks registered by MainScreen
  // ignore: unused_field
  VoidCallback? _goToHome;
  void Function(int index)? _switchTab;
  VoidCallback? _showRoutineTab;
  VoidCallback? _showWishlistTab;
  void Function(Widget screen)? _pushScreen; // ← NEW

  // Register methods
  void registerGoHome(VoidCallback callback) => _goToHome = callback;
  void registerSwitchTab(void Function(int index) callback) =>
      _switchTab = callback;
  void registerShowRoutineTab(VoidCallback callback) =>
      _showRoutineTab = callback;
  void registerShowWishlistTab(VoidCallback callback) =>
      _showWishlistTab = callback;
  void registerPushScreen(void Function(Widget screen) callback) =>
      _pushScreen = callback; // ← NEW

  // Actions
  void switchTab(int index) {
    tabNotifier.value = index;
    _switchTab?.call(index);
  }

  void notifyTabChange(int index) {
    tabNotifier.value = index;
  }

  void goToHome() => switchTab(0);
  void showRoutineTab() => _showRoutineTab?.call();
  void showWishlistTab() => _showWishlistTab?.call();

  /// Pushes any screen on top of the currently active tab's navigator
  void pushScreen(Widget screen) => _pushScreen?.call(screen);

  void switchTabAndPush(int index, Widget screen) {
    switchTab(index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushScreen?.call(screen);
    });
  }
}
