import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/services/tab_navigation_service.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/view/profile/profile_screen.dart';

class RoutineScreen extends StatelessWidget {
  RoutineScreen({super.key});
  final List<Map<String, String>> nightProducts = [
    {
      "image": AppConstants.nightProduct1,
      "step": "STEP 01",
      "title": "Silk Cleansing\nOil",
    },
    {
      "image": AppConstants.nightProduct2,
      "step": "STEP 02",
      "title": "Night Repair\nSerum",
    },
    {
      "image": AppConstants.nightProduct3,
      "step": "STEP 03",
      "title": "Cloud Cream",
    },
    {
      "image": AppConstants.nightProduct4,
      "step": "STEP 04",
      "title": "Brighten Eye\nGel",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        TabNavigationService.instance.switchTab(0);
        TabNavigationService.instance.showWishlistTab();
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: appColors.bg,
          centerTitle: false,
          leadingWidth: 30.w,
          elevation: 0.5,
          shadowColor: appColors.subtitle.withValues(alpha: 0.3),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: appColors.primary),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Text(
            "Koreanza",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: appColors.primary,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: appColors.primary),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person_outline, color: appColors.primary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
          actionsPadding: EdgeInsets.only(right: 10.w),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DAILY RITUALS",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: appColors.primary,
                  ),
                ),
                Text(
                  "Your Routine",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: appColors.title,
                  ),
                ),
                Text(
                  "Nurture your skin with precision. Track your\nprogress and maintain your glow through\nconsistent care.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.subtitle,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 40.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: appColors.secondary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_outlined),
                      SizedBox(width: 10.w),
                      Text(
                        "Schedule",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: appColors.title,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: 45.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: appColors.secondary,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Icon(
                      Icons.wb_sunny_outlined,
                      color: appColors.subtitle,
                      size: 20.sp,
                    ),
                  ),
                  title: Text(
                    "Morning\nRoutine",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: appColors.title,
                    ),
                  ),
                  subtitle: Text(
                    "3 PRODUCTS • 5\nMINUTES",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: appColors.subtitle,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                RoutineStepsContainer(
                  image: AppConstants.routineProduct1,
                  step: "STEP 01",
                  title: "Glow Cleanser",
                  subtitle: "Purify & Prep",
                ),
                RoutineStepsContainer(
                  image: AppConstants.routineProduct2,
                  step: "STEP 02",
                  title: "Mist Essence",
                  subtitle: "Hydrate & balance",
                ),
                RoutineStepsContainer(
                  image: AppConstants.routineProduct3,
                  step: "STEP 03",
                  title: "Daily Shield SPF 50",
                  subtitle: "Protect & Glow",
                ),
                // SizedBox(height: 10.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: 45.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: appColors.title,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Transform.rotate(
                      angle: -0.6,
                      child: Icon(
                        Icons.nightlight_outlined,
                        color: appColors.surface,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  title: Text(
                    "Night\nRoutine",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: appColors.title,
                    ),
                  ),
                  subtitle: Text(
                    "4 PRODUCTS • 8\nMINUTES",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: appColors.subtitle,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) {
                    return RoutineStepsContainer(
                      image: nightProducts[index]["image"]!,
                      step: nightProducts[index]["step"]!,
                      title: nightProducts[index]["title"]!,
                      // subtitle: nightProducts[index]["subtitle"]!,
                      isGrid: true,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                ConsistencyStreakCard(),
                SizedBox(height: 20.h),
                Container(
                  height: 185.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColors.primary,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_awesome_outlined,
                        color: appColors.surface,
                        size: 40.sp,
                      ),
                      Text(
                        "Skin Score",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.surface,
                        ),
                      ),
                      Text(
                        "88",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: appColors.surface,
                        ),
                      ),
                      Text(
                        "Excellent",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoutineStepsContainer extends StatelessWidget {
  RoutineStepsContainer({
    super.key,
    required this.image,
    required this.step,
    required this.title,
    this.subtitle,
    // this.height,
    this.isGrid = false,
  });

  final String image;
  final String step;
  final String title;
  final String? subtitle;
  // final double? height;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      height: isGrid ? 300.h : 430.h,
      width: isGrid ? double.infinity : 360.w,
      margin: EdgeInsets.symmetric(vertical: isGrid ? 0.h : 10.h),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: appColors.border, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isGrid ? 15.w : 20.w,
              vertical: isGrid ? 10.h : 20.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: isGrid ? 20.h : 25.h,
                  width: isGrid ? 55.w : 60.w,
                  decoration: BoxDecoration(
                    color: appColors.secondary,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    step,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: appColors.title,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle_outline,
                  color: appColors.iconColor,
                  size: isGrid ? 14.sp : 18.sp,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isGrid ? 15.w : 20.w),
            child: Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: isGrid ? 12.sp : 16.sp,
                color: appColors.title,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isGrid ? 10.w : 21.w),
            child: Text(
              subtitle ?? "",
              style: GoogleFonts.plusJakartaSans(
                fontSize: isGrid ? 10.sp : 12.sp,
                color: appColors.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConsistencyStreakCard extends StatelessWidget {
  ConsistencyStreakCard({super.key});

  final List<double> barValues = [0.4, 0.55, 0.3, 0.85, 0.6];
  static const double maxHeight = 150; // max bar height

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: appColors.border, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: appColors.subtitle.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Consistency Streak",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: appColors.title,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "You've completed your routine 12 days\nin a row! Keep it up for a radiant glow.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: appColors.subtitle,
            ),
          ),
          SizedBox(
            height: maxHeight.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: barValues
                  .map((value) => _buildBar(context, value))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, double filledRatio) {
    final appColors = AppColors.of(context);
    final double totalHeight = maxHeight.h * filledRatio;
    final double unfilledHeight = totalHeight * 0.3;
    final double filledHeight = totalHeight * 0.7;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: SizedBox(
        height: totalHeight,
        width: 42.w,
        child: Column(
          children: [
            Container(
              height: unfilledHeight,
              color: appColors.secondary.withValues(alpha: 0.3),
            ),
            Container(height: filledHeight, color: appColors.primary),
          ],
        ),
      ),
    );
  }
}
