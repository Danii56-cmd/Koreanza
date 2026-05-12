import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/sharedwidgets/custombutton.dart';
import 'package:koreanza/models/shopproducts_model.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final int subtotal;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return CustomPopScope(
      onBackPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: appColors.bg,
        appBar: AppBar(
          backgroundColor: appColors.bg,
          centerTitle: false,
          elevation: 0.5,
          shadowColor: appColors.subtitle.withValues(alpha: 0.3),
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.menu, color: appColors.primary),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
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
              onPressed: () {},
            ),
          ],
          actionsPadding: EdgeInsets.only(right: 10.w),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Secure Checkout",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      color: appColors.title,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Complete your order to reveal your radiance.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      // fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      color: appColors.subtitle,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Shipping Information
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      border: Border.all(color: appColors.border, width: 1.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              color: appColors.iconColor,
                              size: 20.r,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Shipping Information",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                                color: appColors.title,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Full Name
                        _buildField(
                          label: "Full Name",
                          hint: "Arman Karam",
                          appColors: appColors,
                        ),
                        SizedBox(height: 12.h),
                        // Street Address
                        _buildField(
                          label: "Street Address",
                          hint: "123 Peshawar",
                          appColors: appColors,
                        ),
                        SizedBox(height: 12.h),
                        // City + Phone row
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                label: "City",
                                hint: "Peshawar",
                                appColors: appColors,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildField(
                                label: "Phone",
                                hint: "+92 312 3456789",
                                appColors: appColors,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  // Payment Method
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      border: Border.all(color: appColors.border, width: 1.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: appColors.iconColor,
                              size: 20.r,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Payment Method",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                                color: appColors.title,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Credit Card Information
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: appColors.bg,
                            border: Border.all(
                              color: appColors.iconColor,
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.radio_button_checked,
                                    color: appColors.iconColor,
                                    size: 20.r,
                                  ),
                                  Text(
                                    "Credit/Debit Card",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: GoogleFonts.plusJakartaSans()
                                          .fontFamily,
                                      color: appColors.title,
                                    ),
                                  ),
                                  Icon(
                                    Icons.credit_card,
                                    color: appColors.iconColor,
                                    size: 20.r,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              TextField(
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily:
                                      GoogleFonts.plusJakartaSans().fontFamily,
                                  color: appColors.title,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Card Number",
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: appColors.subtitle.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 12.h,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: appColors.border,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: appColors.border,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    child: _buildField(
                                      hint: "MM/YY",
                                      label: "",
                                      appColors: appColors,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: _buildField(
                                      hint: "CVC",
                                      label: "",
                                      appColors: appColors,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        // Bank Transfer
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.radio_button_off),
                            suffixIcon: Icon(Icons.account_balance_outlined),
                            hintText: "Bank Transfer",
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: appColors.title,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 12.h,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(
                                color: appColors.border,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(
                                color: appColors.border,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: appColors.border, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: appColors.title,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ...cartItems.map((item) {
                          final product = item['product'] as Product;
                          final qty = item['qty'] as int;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 80.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: appColors.border,
                                    image: DecorationImage(
                                      image: AssetImage(product.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: appColors.title,
                                          fontFamily:
                                              GoogleFonts.plusJakartaSans()
                                                  .fontFamily,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "${product.subtitle} (Qty: $qty)",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: appColors.title,
                                          fontFamily:
                                              GoogleFonts.plusJakartaSans()
                                                  .fontFamily,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        product.price,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: appColors.primary,
                                          fontFamily:
                                              GoogleFonts.plusJakartaSans()
                                                  .fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 15.h),
                        Divider(color: appColors.border, thickness: 1),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                            Text(
                              "Pkr $subtotal",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                            Text(
                              "Free",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[700],
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Estimated Tax",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                            Text(
                              "Pkr 50",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: appColors.border, thickness: 1),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                            Text(
                              "Pkr ${subtotal + 50}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          text: "Place Order",
                          onPressed: () {},
                          buttonColor: appColors.iconColor,
                          icon: Icons.lock,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 12.sp,
                              color: appColors.title,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Payments are encrypted and secure",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.title,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.w),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildField({
  required String label,
  required String hint,
  required AppColors appColors,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: appColors.title, // dark label
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        ),
      ),
      SizedBox(height: 6.h),
      TextField(
        style: TextStyle(
          fontSize: 13.sp,
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          color: appColors.title,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: appColors.subtitle.withValues(alpha: 0.6),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: appColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: appColors.border, width: 1.5),
          ),
        ),
      ),
    ],
  );
}
