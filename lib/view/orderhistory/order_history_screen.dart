import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';

// Data models

enum TrackingStatus { completed, active, pending }

class TrackingStep {
  final String label;
  final String subtitle;
  final TrackingStatus status;
  final IconData icon;

  const TrackingStep({
    required this.label,
    required this.subtitle,
    required this.status,
    required this.icon,
  });
}

class OrderProduct {
  final String name;
  final String meta;
  final String tag;
  final String imageAsset;

  const OrderProduct({
    required this.name,
    required this.meta,
    required this.tag,
    required this.imageAsset,
  });
}

// Screen

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});

  // Static demo data

  final List<TrackingStep> _steps = [
    TrackingStep(
      label: 'Order Placed',
      subtitle: 'Oct 18, 10:24 AM',
      status: TrackingStatus.completed,
      icon: Icons.check,
    ),
    TrackingStep(
      label: 'Processing',
      subtitle: 'Oct 19, 02:15 PM',
      status: TrackingStatus.completed,
      icon: Icons.check,
    ),
    TrackingStep(
      label: 'Shipped',
      subtitle: 'Your package is on its way to the local facility.',
      status: TrackingStatus.active,
      icon: Icons.local_shipping_outlined,
    ),
    TrackingStep(
      label: 'Delivered',
      subtitle: 'Estimated Oct 24',
      status: TrackingStatus.pending,
      icon: Icons.inventory_2_outlined,
    ),
  ];

  final List<OrderProduct> _products = [
    OrderProduct(
      name: 'Radiance Boost Serum',
      meta: '30ml • Qty: 1',
      tag: 'VEGAN',
      imageAsset: AppConstants.orderHistoryImage,
    ),
    OrderProduct(
      name: 'Dewy Cloud Moisturizer',
      meta: '50g • Qty: 1',
      tag: 'CRUELTY-FREE',
      imageAsset: AppConstants.orderHistoryImage2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return CustomPopScope(
      child: Scaffold(
        drawer: const CustomDrawer(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: appColors.bg,
        // AppBar
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
            'Korenza',
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
        // Body
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order summary card
                _OrderSummaryCard(appColors: appColors),
                SizedBox(height: 28.h),

                // Tracking timeline
                _TrackingTimeline(steps: _steps, appColors: appColors),
                SizedBox(height: 28.h),

                // Package details
                _PackageDetails(products: _products, appColors: appColors),
                SizedBox(height: 16.h),

                // Total paid
                _TotalPaidCard(appColors: appColors),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Order Summary Card

class _OrderSummaryCard extends StatelessWidget {
  final dynamic appColors;
  const _OrderSummaryCard({required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER  #LUM-88291',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.primary,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Arriving Thursday, Oct 24',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.title,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 14.r, color: appColors.subtitle),
              SizedBox(width: 4.w),
              Text(
                'Peshawar, Pakistan',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: appColors.subtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Tracking Timeline

class _TrackingTimeline extends StatelessWidget {
  final List<TrackingStep> steps;
  final dynamic appColors;

  const _TrackingTimeline({required this.steps, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        final isLast = i == steps.length - 1;
        return _TimelineRow(step: step, isLast: isLast, appColors: appColors);
      }),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final TrackingStep step;
  final bool isLast;
  final dynamic appColors;

  const _TimelineRow({
    required this.step,
    required this.isLast,
    required this.appColors,
  });

  Color get _bubbleBg {
    switch (step.status) {
      case TrackingStatus.completed:
      case TrackingStatus.active:
        return appColors.primary;
      case TrackingStatus.pending:
        return appColors.surface;
    }
  }

  Color get _bubbleFg {
    switch (step.status) {
      case TrackingStatus.completed:
      case TrackingStatus.active:
        return appColors.surface;
      case TrackingStatus.pending:
        return appColors.subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = step.status == TrackingStatus.active;
    final isPending = step.status == TrackingStatus.pending;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: bubble + connector line
          SizedBox(
            width: 44.w,
            child: Column(
              children: [
                // Bubble
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: _bubbleBg,
                    shape: BoxShape.circle,
                    border: isPending
                        ? Border.all(color: appColors.border, width: 1.5)
                        : null,
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: appColors.primary.withValues(alpha: 0.35),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(step.icon, color: _bubbleFg, size: 16.r),
                ),
                // Connector
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      color: isPending
                          ? appColors.border
                          : appColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Right: content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: isActive
                  ? _ActiveShippedCard(step: step, appColors: appColors)
                  : _SimpleStepContent(step: step, appColors: appColors),
            ),
          ),
        ],
      ),
    );
  }
}

// Plain step (Order Placed, Processing, Delivered)
class _SimpleStepContent extends StatelessWidget {
  final TrackingStep step;
  final dynamic appColors;

  const _SimpleStepContent({required this.step, required this.appColors});

  @override
  Widget build(BuildContext context) {
    final isPending = step.status == TrackingStatus.pending;

    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: isPending ? appColors.subtitle : appColors.title,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            step.subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}

// Expanded "Shipped" card with map placeholder
class _ActiveShippedCard extends StatelessWidget {
  final TrackingStep step;
  final dynamic appColors;

  const _ActiveShippedCard({required this.step, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: appColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: appColors.primary.withValues(alpha: 0.25),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipped',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.iconColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            step.subtitle,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.title,
            ),
          ),
          SizedBox(height: 12.h),
          // Map placeholder
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: appColors.secondary.withValues(alpha: 0.3),
            ),
            child: Image.asset(
              AppConstants.locationIcon,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

// Package Details

class _PackageDetails extends StatelessWidget {
  final List<OrderProduct> products;
  final dynamic appColors;

  const _PackageDetails({required this.products, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Package Details',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            color: appColors.title,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: appColors.border, width: 1.2),
          ),
          child: Column(
            children: List.generate(products.length, (i) {
              final isLast = i == products.length - 1;
              return Column(
                children: [
                  _ProductTile(product: products[i], appColors: appColors),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: appColors.border,
                      indent: 16.w,
                      endIndent: 16.w,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _ProductTile extends StatelessWidget {
  final OrderProduct product;
  final dynamic appColors;

  const _ProductTile({required this.product, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 60.r,
              height: 60.r,
              color: appColors.primary.withValues(alpha: 0.08),
              child: Image.asset(
                product.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.spa_outlined,
                  color: appColors.primary,
                  size: 28.r,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Name, meta, tag
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: appColors.title,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  product.meta,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: appColors.subtitle,
                  ),
                ),
                SizedBox(height: 6.h),
                // Tag chip
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: appColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    product.tag,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      color: appColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Total Paid Card

class _TotalPaidCard extends StatelessWidget {
  final dynamic appColors;
  const _TotalPaidCard({required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: appColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: appColors.primary.withValues(alpha: 0.18),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Paid',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: appColors.title,
                ),
              ),
              Text(
                'PKr 999',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: appColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Visa ending in 4242  •  Bill to 221B Baker St.',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                color: appColors.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
