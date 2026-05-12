import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanza/core/app_colors.dart'; // import your AppColors class

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 54.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? appColors.primary,
          foregroundColor: appColors.surface,
          elevation: 4,
          shadowColor: appColors.primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: textColor ?? appColors.surface,
              ),
            ),
            SizedBox(width: 8.w),
            if (icon != null) Icon(icon, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
