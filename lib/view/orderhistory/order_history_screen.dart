import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/models/cart_model.dart';
import 'package:koreanza/models/order_model.dart';
import 'package:koreanza/providers/order_provider.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

// Tracking helpers

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

List<TrackingStep> _buildSteps(String status, DateTime orderDate) {
  final fmt = DateFormat('MMM d, hh:mm a');
  final placed = fmt.format(orderDate);
  final processed = fmt.format(orderDate.add(const Duration(days: 1)));
  final estimatedDelivery = DateFormat(
    'MMM d',
  ).format(orderDate.add(const Duration(days: 5)));

  final isShipped = status == 'Shipped';
  final isDelivered = status == 'Delivered';
  final processComplete = isShipped || isDelivered;

  return [
    TrackingStep(
      label: 'Order Placed',
      subtitle: placed,
      status: TrackingStatus.completed,
      icon: Icons.check,
    ),
    TrackingStep(
      label: 'Processing',
      subtitle: processComplete ? processed : 'We are preparing your package.',
      status: processComplete
          ? TrackingStatus.completed
          : TrackingStatus.active,
      icon: processComplete ? Icons.check : Icons.check,
    ),
    TrackingStep(
      label: 'Shipped',
      subtitle: 'Your package is on its way to the local facility.',
      status: isDelivered
          ? TrackingStatus.completed
          : isShipped
          ? TrackingStatus.active
          : TrackingStatus.pending,
      icon: isDelivered ? Icons.check : Icons.local_shipping_outlined,
    ),
    TrackingStep(
      label: 'Delivered',
      subtitle: 'Estimated $estimatedDelivery',
      status: isDelivered ? TrackingStatus.completed : TrackingStatus.pending,
      icon: isDelivered ? Icons.check : Icons.inventory_2_outlined,
    ),
  ];
}

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return CustomPopScope(
      child: Scaffold(
        drawer: const CustomDrawer(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: appColors.bg,
        appBar: AppBar(
          backgroundColor: appColors.bg,
          centerTitle: false,
          leadingWidth: 30.w,
          elevation: 0.5,
          shadowColor: appColors.subtitle.withValues(alpha: 0.3),
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.menu, color: appColors.primary),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          title: Text(
            'Koreanza',
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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.only(right: 10.w),
        ),
        body: Consumer<OrderProvider>(
          builder: (context, provider, _) {
            if (provider.orders.isEmpty) {
              return _EmptyState(appColors: appColors);
            }
            final order = provider.orders.last;
            return _OrderDetailBody(order: order, appColors: appColors);
          },
        ),
      ),
    );
  }
}

// Empty State

class _EmptyState extends StatelessWidget {
  final AppColors appColors;
  const _EmptyState({required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 72.r,
              color: appColors.border,
            ),
            SizedBox(height: 16.h),
            Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: appColors.title,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your placed orders will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: appColors.subtitle,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Order Detail Body

class _OrderDetailBody extends StatelessWidget {
  final OrderModel order;
  final AppColors appColors;
  const _OrderDetailBody({required this.order, required this.appColors});

  @override
  Widget build(BuildContext context) {
    final steps = _buildSteps(order.status, order.createdAt);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrderSummaryCard(order: order, appColors: appColors),
            SizedBox(height: 28.h),
            _TrackingTimeline(steps: steps, appColors: appColors),
            SizedBox(height: 28.h),
            _PackageDetails(order: order, appColors: appColors),
            SizedBox(height: 16.h),
            _TotalPaidCard(order: order, appColors: appColors),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

// Order Summary Card

class _OrderSummaryCard extends StatelessWidget {
  final OrderModel order;
  final AppColors appColors;
  const _OrderSummaryCard({required this.order, required this.appColors});

  @override
  Widget build(BuildContext context) {
    final orderId = 'KRZ-${order.createdAt.millisecondsSinceEpoch % 100000}';
    final arrivalDate = DateFormat(
      'EEEE, MMM d',
    ).format(order.createdAt.add(const Duration(days: 5)));

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
          // Order ID
          Text(
            'ORDER  #$orderId',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.primary,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 4.h),

          // Arrival estimate
          Text(
            'Arriving $arrivalDate',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.title,
            ),
          ),
          SizedBox(height: 8.h),

          // Recipient name
          Row(
            children: [
              Icon(Icons.person_outline, size: 14.r, color: appColors.subtitle),
              SizedBox(width: 4.w),
              Text(
                order.fullName.isNotEmpty ? order.fullName : 'N/A',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: appColors.title,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, size: 14.r, color: appColors.subtitle),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  [
                    if (order.address.isNotEmpty) order.address,
                    if (order.city.isNotEmpty) order.city,
                  ].join(', '),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: appColors.subtitle,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Phone
          Row(
            children: [
              Icon(Icons.phone_outlined, size: 14.r, color: appColors.subtitle),
              SizedBox(width: 4.w),
              Text(
                order.phone.isNotEmpty ? order.phone : 'N/A',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: appColors.subtitle,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
  final AppColors appColors;
  const _TrackingTimeline({required this.steps, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        return _TimelineRow(
          step: steps[i],
          isLast: i == steps.length - 1,
          appColors: appColors,
        );
      }),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final TrackingStep step;
  final bool isLast;
  final AppColors appColors;
  const _TimelineRow({
    required this.step,
    required this.isLast,
    required this.appColors,
  });

  Color get _bubbleBg => switch (step.status) {
    TrackingStatus.completed || TrackingStatus.active => appColors.primary,
    TrackingStatus.pending => appColors.surface,
  };

  Color get _bubbleFg => switch (step.status) {
    TrackingStatus.completed || TrackingStatus.active => appColors.surface,
    TrackingStatus.pending => appColors.subtitle,
  };

  @override
  Widget build(BuildContext context) {
    final isActive = step.status == TrackingStatus.active;
    final isPending = step.status == TrackingStatus.pending;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bubble + connector
          SizedBox(
            width: 44.w,
            child: Column(
              children: [
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

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: isActive
                  ? _ActiveStepCard(step: step, appColors: appColors)
                  : _StepContent(step: step, appColors: appColors),
            ),
          ),
        ],
      ),
    );
  }
}

// step content
class _StepContent extends StatelessWidget {
  final TrackingStep step;
  final AppColors appColors;
  const _StepContent({required this.step, required this.appColors});

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
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}

// Active step card — shown for Processing, Shipped, or any active step
class _ActiveStepCard extends StatelessWidget {
  final TrackingStep step;
  final AppColors appColors;
  const _ActiveStepCard({required this.step, required this.appColors});

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
            step.label,
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
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.title,
            ),
          ),
          SizedBox(height: 12.h),
          // Tracking map image shown for all active steps
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              AppConstants.locationIcon,
              height: 120.h,
              width: double.infinity,
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
  final OrderModel order;
  final AppColors appColors;
  const _PackageDetails({required this.order, required this.appColors});

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
            children: List.generate(order.items.length, (i) {
              final isLast = i == order.items.length - 1;
              return Column(
                children: [
                  _ProductTile(item: order.items[i], appColors: appColors),
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

// product tile
class _ProductTile extends StatelessWidget {
  final CartItemModel item;
  final AppColors appColors;
  const _ProductTile({required this.item, required this.appColors});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final qty = item.qty;
    final tag = (product.badge != null && product.badge!.isNotEmpty)
        ? product.badge!
        : 'NATURAL';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 60.r,
              height: 60.r,
              color: appColors.primary.withValues(alpha: 0.08),
              child: Image.asset(
                product.image,
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
                  '${product.subtitle}  •  Qty: $qty',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: appColors.subtitle,
                  ),
                ),
                SizedBox(height: 6.h),
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
                    tag.toUpperCase(),
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
  final OrderModel order;
  final AppColors appColors;
  const _TotalPaidCard({required this.order, required this.appColors});

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
                'PKR ${order.total}',
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
              '${order.paymentMethod}  •  ${order.address}, ${order.city}',
              style: TextStyle(
                fontSize: 12.sp,
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
