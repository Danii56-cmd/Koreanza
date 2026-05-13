import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/services/tab_navigation_service.dart';
import 'package:koreanza/view/cart/cart_screen.dart';
import 'package:koreanza/view/home/home_screen.dart';
import 'package:koreanza/view/myroutine/my_routine_screen.dart';
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

  /// Controls whether tab 2 is Wishlist or Routine
  bool _showRoutineTab = false;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  List<Widget> get _screens => [
    const HomeScreen(),
    const ShoppingScreen(),

    _showRoutineTab ? const RoutineScreen() : const WishlistScreen(),

    const CartScreen(),
    const ProfileScreen(),
  ];

  List<_NavItem> get _navItems => [
    _NavItem(label: 'HOME', icon: Icons.home_outlined, activeIcon: Icons.home),

    _NavItem(
      label: 'SHOP',
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
    ),

    _NavItem(
      label: _showRoutineTab ? 'ROUTINE' : 'WISHLIST',
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

  @override
  void initState() {
    super.initState();
    // Register tab switch callback
    TabNavigationService.instance.registerSwitchTab((index) {
      if (!mounted) return;

      if (_selectedIndex == index) {
        _navigatorKeys[index].currentState?.popUntil((r) => r.isFirst);
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    });

    TabNavigationService.instance.registerGoHome(() {
      if (!mounted) return;
      TabNavigationService.instance.switchTab(0);
    });

    TabNavigationService.instance.registerShowRoutineTab(showRoutineTab);
    TabNavigationService.instance.registerShowWishlistTab(showWishlistTab);
  }

  void showRoutineTab() {
    setState(() {
      _showRoutineTab = true;
      _selectedIndex = 2;
    });
    TabNavigationService.instance.notifyTabChange(2);
  }

  void showWishlistTab() {
    setState(() {
      _showRoutineTab = false;
      _selectedIndex = 2;
    });
    TabNavigationService.instance.notifyTabChange(2);
  }

  void _onPopInvoked(bool didPop, _) {
    final NavigatorState? nav = _navigatorKeys[_selectedIndex].currentState;
    if (nav != null && nav.canPop()) {
      nav.pop();
    } else if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      TabNavigationService.instance.notifyTabChange(0);
    }
  }

  void _onTabTapped(int index) {
    if (index == 2) {
      setState(() {
        _showRoutineTab = false;
      });
    }
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });

      TabNavigationService.instance.notifyTabChange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,

      child: Scaffold(
        // BODY
        body: IndexedStack(
          index: _selectedIndex,

          children: List.generate(_screens.length, (index) {
            return Navigator(
              key: _navigatorKeys[index],

              onGenerateRoute: (settings) => MaterialPageRoute(
                settings: settings,
                builder: (_) => _screens[index],
              ),
            );
          }),
        ),

        // BOTTOM NAV
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
                  final item = _navItems[index];

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

// Nav Item Model
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
