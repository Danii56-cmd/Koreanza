import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanza/core/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    final List<Map<String, dynamic>> tabs = [
      {'icon': Icons.face_outlined, 'label': 'Face'},
      {'icon': Icons.clean_hands_outlined, 'label': 'Acne'},
      {'icon': Icons.wb_sunny_outlined, 'label': 'Glow'},
      {'icon': Icons.water_drop_outlined, 'label': 'Serum'},
    ];

    return SizedBox(
      height: 85.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tabs.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: 30.w,
            ), // Matching the spacing in your Home.jpg
            child: TabBarIcons(
              appColors: appColors,
              icon: tabs[index]['icon'] as IconData,
              label: tabs[index]['label'] as String,
            ),
          );
        },
      ),
    );
  }
}

class TabBarIcons extends StatelessWidget {
  final IconData icon;
  final String label;
  final AppColors appColors;

  const TabBarIcons({
    super.key,
    required this.appColors,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.w, // Shorter width (was 60.w)
            height: 50.w, // Shorter height (was 60.w)
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.primary.withValues(alpha: 0.12),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24.sp, // Scaled down icon (was 28.sp)
                color: appColors.subtitle,
              ),
            ),
          ),
          SizedBox(height: 6.h), // Tighter gap (was 8.h)
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp, // Slightly smaller text (was 13.sp)
              color: appColors.title,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
