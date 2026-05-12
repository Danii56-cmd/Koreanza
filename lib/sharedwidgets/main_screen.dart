import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/services/tab_navigation_service.dart';
import 'package:koreanza/view/cart/cart_screen.dart';
import 'package:koreanza/view/home/home_screen.dart';
import 'package:koreanza/view/profile/profile_screen.dart';
import 'package:koreanza/view/shopping/shopping_screen.dart';
import 'package:koreanza/view/wishlist/wishlist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // One GlobalKey<NavigatorState> per tab so each tab owns its own nav stack.
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  // Root screen for every tab — created once in initState.
  late final List<Widget> _screens;

  static const List<_NavItem> _navItems = [
    _NavItem(label: 'HOME', icon: Icons.home_outlined, activeIcon: Icons.home),
    _NavItem(
      label: 'SHOP',
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
    ),
    _NavItem(
      label: 'WISHLIST',
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
    ),
    _NavItem(
      label: 'CART',
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
    ),
    _NavItem(
      label: 'PROFILE',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  // Lifecycle

  @override
  void initState() {
    super.initState();

    _screens = [
      const HomeScreen(),
      const ShoppingScreen(),
      const WishlistScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    // Register the go-home callback so CustomPopScope can trigger a tab switch
    // from any screen without needing BuildContext or state management.
    TabNavigationService.instance.registerGoHome(() {
      if (!mounted) return;
      if (_selectedIndex != 0) {
        setState(() => _selectedIndex = 0);
      }
    });
  }

  // Helpers

  void _onPopInvoked(bool didPop, _) {
    final NavigatorState? nav = _navigatorKeys[_selectedIndex].currentState;

    if (nav != null && nav.canPop()) {
      // Still has routes inside the tab stack → pop one level.
      nav.pop();
    } else if (_selectedIndex != 0) {
      // At the root of a non-home tab → go to Home.
      setState(() => _selectedIndex = 0);
    }
  }

  void _onTabTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  // Build

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return PopScope(
      // Never let the root navigator pop — we control back behaviour ourselves.
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,
      child: Scaffold(
        // Body
        body: IndexedStack(
          index: _selectedIndex,
          children: List.generate(_screens.length, (index) {
            return Navigator(
              key: _navigatorKeys[index],
              // Each tab starts with its root screen.
              onGenerateRoute: (settings) => MaterialPageRoute(
                settings: settings,
                builder: (_) => _screens[index],
              ),
            );
          }),
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: [
              BoxShadow(
                color: appColors.title.withValues(alpha: 0.07),
                blurRadius: 20.r,
                offset: Offset(0, -4.r),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (index) {
                  final _NavItem item = _navItems[index];
                  final bool isActive = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => _onTabTapped(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? appColors.primary.withValues(alpha: 0.10)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon
                          Icon(
                            isActive ? item.activeIcon : item.icon,
                            size: 22.r,
                            color: isActive
                                ? appColors.primary
                                : appColors.subtitle,
                          ),
                          SizedBox(height: 2.h),
                          // Label
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: isActive
                                  ? appColors.primary
                                  : appColors.subtitle,
                              fontFamily:
                                  GoogleFonts.plusJakartaSans().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Type-safe nav item model
class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}
