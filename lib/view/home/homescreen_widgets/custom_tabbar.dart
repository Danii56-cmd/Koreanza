import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    final List<Map<String, String>> tabs = [
      {'icon': AppConstants.homeIcon1, 'label': 'Face'},
      {'icon': AppConstants.homeIcon2, 'label': 'Acne'},
      {'icon': AppConstants.homeIcon3, 'label': 'Glow'},
      {'icon': AppConstants.homeIcon4, 'label': 'Serum'},
    ];

    return SizedBox(
      height: 90.h, // increased to fit label
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TabBarIcons(
              appColors: appColors,
              iconPath: tabs[index]['icon']!,
              label: tabs[index]['label']!,
            ),
          );
        },
      ),
    );
  }
}

class TabBarIcons extends StatelessWidget {
  final String iconPath;
  final String label;
  final AppColors appColors;

  const TabBarIcons({
    super.key,
    required this.appColors,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // handle tab selection
      },
      child: Column(
        // ← wrap in Column
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 55.w,
            height: 55.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.secondary,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                // width: 35.w,
                // height: 35.w,
                color: appColors.title,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: appColors.title,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
