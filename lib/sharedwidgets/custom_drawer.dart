import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/services/tab_navigation_service.dart';
import 'package:koreanza/view/aboutus/aboutus_screen.dart';
import 'package:koreanza/view/orderhistory/order_history_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // Maps bottom-nav index → drawer label (only for tabs that exist in the nav bar)
  final _indexToLabel = {
    0: 'Home',
    1: 'Shop All',
    2: 'Wishlist',
    3: 'Cart',
    4: 'Settings',
  };

  String _selectedItem = 'Home';

  @override
  void initState() {
    super.initState();
    _syncIndex();
    TabNavigationService.instance.tabNotifier.addListener(_syncIndex);
  }

  @override
  void dispose() {
    TabNavigationService.instance.tabNotifier.removeListener(_syncIndex);
    super.dispose();
  }

  void _syncIndex() {
    final label = _indexToLabel[TabNavigationService.instance.currentIndex];
    if (label != null && mounted) setState(() => _selectedItem = label);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Drawer(
      backgroundColor: appColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundImage: AssetImage(AppConstants.profile),
                  ),
                  SizedBox(width: 14.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Sophie",
                        style: TextStyle(
                          color: appColors.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Skincare Enthusiast",
                        style: TextStyle(
                          color: appColors.subtitle,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Scrollable Menu Body
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main nav
                    _NavItem(
                      icon: Icons.home_filled,
                      label: "Home",
                      isActive: _selectedItem == 'Home',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,
                      onTap: () {
                        setState(() => _selectedItem = 'Home');
                        Navigator.pop(context);
                        TabNavigationService.instance.switchTab(0);
                      },
                    ),
                    _NavItem(
                      icon: Icons.grid_view_outlined,
                      label: "Shop All",
                      isActive: _selectedItem == 'Shop All',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,
                      onTap: () {
                        setState(() => _selectedItem = 'Shop All');
                        Navigator.pop(context);
                        TabNavigationService.instance.switchTab(1);
                      },
                    ),

                    // Categories section
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 16.h,
                        bottom: 4.h,
                      ),
                      child: Text(
                        "CATEGORIES",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: appColors.subtitle,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    ...["Face", "Acne", "Glow", "Serum"].map(
                      (cat) => _CategoryItem(
                        label: cat,
                        dotColor: appColors.secondary,
                        titleColor: appColors.title,
                        isActive: _selectedItem == cat,
                        activeColor: appColors.primary,
                        onTap: () {
                          setState(() => _selectedItem = cat);
                          Navigator.pop(context);
                          TabNavigationService.instance.switchTab(1);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: Divider(
                        thickness: 0.5,
                        color: appColors.subtitle.withValues(alpha: 0.3),
                      ),
                    ),

                    // Secondary nav
                    _NavItem(
                      icon: Icons.calendar_today_outlined,
                      label: "My Routine",
                      isActive: _selectedItem == 'My Routine',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,

                      onTap: () {
                        setState(() {
                          _selectedItem = 'My Routine';
                        });

                        Navigator.pop(context);

                        // Open Routine inside bottom nav
                        TabNavigationService.instance.showRoutineTab();
                      },
                    ),
                    _NavItem(
                      icon: Icons.favorite_border,
                      label: "Wishlist",
                      isActive: _selectedItem == 'Wishlist',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,
                      onTap: () {
                        setState(() => _selectedItem = 'Wishlist');
                        Navigator.pop(context);
                        TabNavigationService.instance.switchTab(2);
                      },
                    ),
                    _NavItem(
                      icon: Icons.history,
                      label: "Order History",
                      isActive: _selectedItem == 'Order History',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (_) => OrderHistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _NavItem(
                      icon: Icons.settings_outlined,
                      label: "Settings",
                      isActive: _selectedItem == 'Settings',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,
                      onTap: () {
                        setState(() => _selectedItem = 'Settings');
                        Navigator.pop(context);
                        TabNavigationService.instance.switchTab(4);
                      },
                    ),
                    _NavItem(
                      icon: Icons.info_outline,
                      label: "About Us",
                      isActive: _selectedItem == 'About Us',
                      activeColor: appColors.primary,
                      subtitleColor: appColors.subtitle,
                      onTap: () {
                        setState(() => _selectedItem = 'About Us');
                        Navigator.pop(context); // close drawer
                        TabNavigationService.instance.switchTabAndPush(
                          4, // switch to last tab (Profile)
                          const AboutUs(), // push AboutUs on top of it
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Logout Button
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: appColors.secondary,
                      width: 1.2.w,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: appColors.primary,
                        size: 18.r,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: appColors.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable nav tile
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color subtitleColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.subtitleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : subtitleColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20.r),
            SizedBox(width: 14.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable category tile
class _CategoryItem extends StatelessWidget {
  final String label;
  final Color dotColor;
  final Color titleColor;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.label,
    required this.dotColor,
    required this.titleColor,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : titleColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              width: 7.r,
              height: 7.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? activeColor : dotColor,
              ),
            ),
            SizedBox(width: 18.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
