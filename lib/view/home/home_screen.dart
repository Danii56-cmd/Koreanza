import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custombutton.dart';
import 'package:koreanza/view/home/homescreen_widgets/featured_products.dart';
import 'package:koreanza/view/home/homescreen_widgets/custom_tabbar.dart';
import 'package:koreanza/view/home/homescreen_widgets/review_container.dart';
import 'package:koreanza/view/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              backgroundColor: appColors.bg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: Text(
                "Exit App",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: appColors.title,
                ),
              ),
              content: Text(
                "Do you really want to exit the app?",
                style: TextStyle(fontSize: 16, color: appColors.subtitle),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: appColors.title,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: appColors.iconColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 05.h,
                          ),
                          child: Text(
                            "Exit",
                            style: TextStyle(
                              color: appColors.surface,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        if (shouldExit == true) {
          // close app
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: appColors.bg,
        appBar: AppBar(
          backgroundColor: appColors.bg,
          centerTitle: false,
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              children: [
                Container(
                  height: 250.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(40, 63, 0, 26),
                        Color.fromARGB(100, 63, 0, 26),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: AssetImage(AppConstants.homeContainer),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        appColors.subtitle.withValues(alpha: 0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      bottom: 20.h,
                      right: 50.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Radiate beauty with natural confidence.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: appColors.surface,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          width: 150.w,
                          height: 50.h,
                          text: "Shop Now",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: appColors.title,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: appColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTabBar(),
                SizedBox(height: 20.h),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColors.secondary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      bottom: 20.h,
                      right: 50.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LIMITED TIME OFFER",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: appColors.subtitle.withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "20% OFF On Your First Order",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: appColors.title,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: 120.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: appColors.title,
                          ),
                          child: Center(
                            child: Text(
                              "Claim Now",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: appColors.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                FeaturedProducts(),
                Text(
                  "Radiant Reviews",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: appColors.title,
                  ),
                ),
                Text(
                  "See what our community is saying",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: appColors.subtitle,
                  ),
                ),
                SizedBox(height: 20.h),
                ReviewSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
