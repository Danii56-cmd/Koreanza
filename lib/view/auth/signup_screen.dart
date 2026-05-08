import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/sharedwidgets/custombutton.dart';
import 'package:koreanza/view/auth/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              // App Name
              Text(
                "Koreanza",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w400,
                  color: appColors.primary,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8.h),
              // Tagline
              Text(
                "START YOUR RADIANCE JOURNEY",
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
                    CustomTextField(
                      hintText: "John Doe",
                      labelText: "Full Name",
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: 16.h),
                    // Email Field
                    CustomTextField(
                      hintText: "hello@korenza.com",
                      labelText: "Email Address",
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: "••••••••",
                      labelText: "Password",
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
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: "••••••••",
                      labelText: "Confirm Password",
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
                    PrimaryButton(
                      text: "Create Account",
                      icon: Icons.arrow_forward,
                      onPressed: () {},
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
                            "OR CONTINUE WITH",
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: appColors.surface,
                            border: Border.all(
                              color: appColors.border,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                                color: appColors.title,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Continue with Google",
                                style: TextStyle(
                                  color: appColors.title,
                                  fontSize: 14.sp,
                                  // fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: appColors.title,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apple,
                                color: appColors.surface,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Continue with Apple",
                                style: TextStyle(
                                  color: appColors.surface,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: appColors.subtitle,
                      fontSize: 14.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Log In",
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
