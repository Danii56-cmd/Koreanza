import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/sharedwidgets/custombutton.dart';
import 'package:koreanza/sharedwidgets/main_screen.dart';
import 'package:koreanza/view/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: appColors.bgGradient),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Container
              Container(
                height: 50.h,
                width: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: appColors.surface,
                  border: Border.all(color: appColors.border, width: 1),
                ),
                child: Icon(
                  Icons.auto_awesome_outlined,
                  size: 28.sp,
                  color: appColors.primary,
                ),
              ),
              SizedBox(height: 24.h),
              // App Name
              Text(
                "Koreanza",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.title,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8.h),
              // Tagline
              Text(
                "Indulge in your skin's true radiance.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: appColors.subtitle,
                  // fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: appColors.surface,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: appColors.border, width: 0.5),
                ),
                child: Column(
                  children: [
                    // Email Field
                    CustomTextField(
                      hintText: "hello@korenza.com",
                      labelText: "Email Address",
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: 16.h),

                    // Password Field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),

                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: appColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      hintText: "••••••••",
                      labelText: "",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      suffix: IconButton(
                        icon: Icon(
                          Icons.visibility_outlined,
                          color: appColors.subtitle,
                          size: 20.sp,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Login Button
                    CustomButton(
                      text: "Login",
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: appColors.border, thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "OR CONNECT WITH",
                            style: TextStyle(
                              color: appColors.subtitle,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: appColors.border, thickness: 1),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: appColors.surface,
                            border: Border.all(
                              color: appColors.border,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Google",
                              style: TextStyle(
                                color: appColors.title,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: appColors.surface,
                            border: Border.all(
                              color: appColors.border,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Apple",
                              style: TextStyle(
                                color: appColors.title,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: AssetImage(AppConstants.loginImage),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      appColors.primary.withValues(alpha: 0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h, left: 20.w),
                    child: Text(
                      "Glow with confidence",
                      style: TextStyle(
                        color: appColors.surface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: appColors.subtitle,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: appColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final bool isPassword;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.labelText,
    this.isPassword = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Label
        if (labelText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
            child: Text(
              labelText,
              style: TextStyle(
                color: appColors.title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        // TextField
        Container(
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextField(
            obscureText: isPassword,
            style: TextStyle(color: appColors.title, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: appColors.subtitle.withValues(alpha: 0.6),
                fontSize: 14.sp,
              ),

              prefixIcon: Icon(
                prefixIcon,
                color: appColors.subtitle,
                size: 20.sp,
              ),
              suffixIcon: suffix,
              filled: true,
              fillColor: appColors.surface,
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 16.w,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: appColors.border, width: 1),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: appColors.border, width: 1),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: appColors.primary, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
