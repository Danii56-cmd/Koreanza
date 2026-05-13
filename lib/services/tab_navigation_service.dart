import 'package:flutter/material.dart';

/// Singleton service that keeps the bottom-nav tab in sync across the app
/// (drawer, back navigation, direct taps) without BuildContext or prop-drilling.
class TabNavigationService {
  TabNavigationService._();

  static final TabNavigationService instance = TabNavigationService._();

  // State

  /// Always reflects the active tab index.
  final ValueNotifier<int> tabNotifier = ValueNotifier(0);

  int get currentIndex => tabNotifier.value;

  // Internal callbacks registered by MainScreen

  // ignore: unused_field
  VoidCallback? _goToHome;

  void Function(int index)? _switchTab;

  VoidCallback? _showRoutineTab;

  VoidCallback? _showWishlistTab;

  // Register methods

  void registerGoHome(VoidCallback callback) {
    _goToHome = callback;
  }

  void registerSwitchTab(void Function(int index) callback) {
    _switchTab = callback;
  }

  void registerShowRoutineTab(VoidCallback callback) {
    _showRoutineTab = callback;
  }

  void registerShowWishlistTab(VoidCallback callback) {
    _showWishlistTab = callback;
  }

  /// Called by drawer or any widget
  void switchTab(int index) {
    tabNotifier.value = index;
    _switchTab?.call(index);
  }

  /// Called by MainScreen to sync notifier only
  void notifyTabChange(int index) {
    tabNotifier.value = index;
  }

  void goToHome() {
    switchTab(0);
  }

  /// Opens Routine in bottom nav
  void openRoutineTab() {
    _showRoutineTab?.call();
  }

  /// Opens Wishlist in bottom nav
  void openWishlistTab() {
    _showWishlistTab?.call();
  }
}
