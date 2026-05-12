import 'dart:ui';

// on the MainScreen without needing BuildContext or state management.
class TabNavigationService {
  TabNavigationService._();
  static final TabNavigationService instance = TabNavigationService._();

  VoidCallback? _goToHome;

  // Called once by MainScreen in initState.
  void registerGoHome(VoidCallback callback) => _goToHome = callback;

  // Called by CustomPopScope when back is pressed on a root tab screen.
  void goToHome() => _goToHome?.call();
}
