import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/view/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _activeDot = 0;

  @override
  void initState() {
    super.initState();

    // Cycle active dot every 400ms
    Stream.periodic(const Duration(milliseconds: 400)).listen((_) {
      if (!mounted) return;
      setState(() => _activeDot = (_activeDot + 1) % 3);
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appcolors = AppColors.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: appcolors.bgGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100.h,
              width: 300.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: appcolors.surface,
                boxShadow: [
                  BoxShadow(
                    color: appcolors.title.withValues(alpha: 0.2),
                    blurRadius: 20.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Text(
                "KOREANZA",
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w900,
                  color: appcolors.primary,
                  fontFamily: GoogleFonts.philosopher().fontFamily,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            CircularProgressIndicator(
              color: appcolors.primary,
              strokeWidth: 2.r,
              backgroundColor: appcolors.primary.withValues(alpha: 0.1),
            ),
            SizedBox(height: 10.h),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 16.sp,
                color: appcolors.primary.withValues(alpha: 0.6),
                fontFamily: GoogleFonts.orbitron().fontFamily,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 100.h),
            Text(
              "PERFECTING YOUR GLOW...",
              style: TextStyle(
                fontSize: 14.sp,
                color: appcolors.title,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                letterSpacing: 1.8,
              ),
            ),
            SizedBox(height: 10.h),
            // Animated dots
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    ".",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: _activeDot == i
                          ? appcolors.primary
                          : appcolors.title.withValues(alpha: 0.3),
                    ),
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
