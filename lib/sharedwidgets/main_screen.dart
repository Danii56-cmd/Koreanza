import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
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

  // Replace with your actual screen widgets
  final List<Widget> _screens = [
    const HomeScreen(),
    const ShoppingScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  static const _navItems = [
    {'label': 'HOME', 'icon': Icons.home_outlined, 'activeIcon': Icons.home},
    {
      'label': 'SHOP',
      'icon': Icons.grid_view_outlined,
      'activeIcon': Icons.grid_view,
    },
    {
      'label': 'WISHLIST',
      'icon': Icons.favorite_outline,
      'activeIcon': Icons.favorite,
    },
    {
      'label': 'CART',
      'icon': Icons.shopping_bag_outlined,
      'activeIcon': Icons.shopping_bag,
    },
    {
      'label': 'PROFILE',
      'icon': Icons.person_outline,
      'activeIcon': Icons.person,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Scaffold(
      body: _screens[_selectedIndex],
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
                final isActive = _selectedIndex == index;

                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon with pink Rectangle when active
                      AnimatedContainer(
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
                            Icon(
                              isActive
                                  ? item['activeIcon'] as IconData
                                  : item['icon'] as IconData,
                              size: 22.r,
                              color: isActive
                                  ? appColors.primary
                                  : appColors.subtitle,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              item['label'] as String,
                              style: TextStyle(
                                fontSize: 08.sp,
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
                      SizedBox(height: 2.h),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
