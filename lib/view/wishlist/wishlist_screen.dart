import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/models/wishlist_model.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';

// Sample data
final List<WishlistProduct> _wishlistProducts = [
  WishlistProduct(
    name: 'Radiance Elixir Serum',
    subtitle: 'Hydrating Glow\nSerum',
    price: 'Pkr 999',
    rating: 4.9,
    image: AppConstants.wishlistIcon1,
    badge: 'NEW',
    badgeColor: Color.fromARGB(255, 255, 209, 227),
  ),
  WishlistProduct(
    name: 'Velvet Cloud Cream',
    subtitle: 'Ceramide\nMoisturizer',
    price: 'Pkr 999',
    rating: 4.8,
    image: AppConstants.wishlistIcon2,
    badge: 'BEST SELLER',
    badgeColor: Color.fromARGB(255, 255, 209, 227),
  ),
  WishlistProduct(
    name: 'Glow Botanical Oil',
    subtitle: 'Gentle Foaming\nWash',
    price: 'Pkr 999',
    rating: 4.7,
    image: AppConstants.wishlistIcon3,
    badge: 'VEGAN',
    badgeColor: Color.fromARGB(255, 255, 209, 227),
  ),
  WishlistProduct(
    name: 'Hydra-Burst Mask',
    subtitle: 'Restorative Elixir',
    price: 'Pkr 999',
    rating: 5.0,
    image: AppConstants.wishlistIcon4,
    badge: 'LIMITED',
    badgeColor: Color.fromARGB(255, 255, 209, 227),
  ),
];

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final cardWidth = (MediaQuery.of(context).size.width - 40.w - 14.w) / 2;

    return CustomPopScope(
      child: Scaffold(
        drawer: const CustomDrawer(),
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
              onPressed: () => Scaffold.of(context).openDrawer(),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wishlist",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: appColors.title,
                          ),
                        ),
                        Text(
                          "12 Items",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: appColors.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: appColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: appColors.iconColor,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Share List",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: appColors.iconColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 14.w,
                  runSpacing: 14.h,
                  children: _wishlistProducts
                      .map(
                        (p) => SizedBox(
                          width: cardWidth,
                          child: WishlistProductCard(product: p),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20.h),
                Icon(
                  Icons.auto_awesome_outlined,
                  color: appColors.secondary,
                  size: 45.sp,
                ),
                Text(
                  "Add more favorites\nto your ritual",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    color: appColors.subtitle.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// WishList Product card
class WishlistProductCard extends StatefulWidget {
  final WishlistProduct product;
  const WishlistProductCard({super.key, required this.product});

  @override
  State<WishlistProductCard> createState() => _WishlistProductCardState();
}

class _WishlistProductCardState extends State<WishlistProductCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final p = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: appColors.subtitle.withValues(alpha: 0.07),
            blurRadius: 12.r,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with badge + heart
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.asset(
                  p.image,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Badge bottom-left (only if provided)
              if (p.badge != null)
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: p.badgeColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      p.badge!,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: appColors.surface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

              // Heart top-right
              Positioned(
                top: 8.r,
                right: 8.r,
                child: GestureDetector(
                  onTap: () => setState(() => _isFav = !_isFav),
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: appColors.subtitle.withValues(alpha: 0.1),
                          blurRadius: 6.r,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isFav ? Icons.favorite : Icons.favorite_border,
                      size: 16.r,
                      color: appColors.iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Card body
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Star rating
                Row(
                  children: [
                    Icon(Icons.star, color: appColors.primary, size: 13.r),
                    SizedBox(width: 3.w),
                    Text(
                      p.rating.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.title,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                // Product name
                Text(
                  p.name,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.title,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),

                // Subtitle
                Text(
                  p.subtitle,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: appColors.subtitle,
                    height: 1.4,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 8.h),
                // Price
                Text(
                  p.price,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: appColors.primary,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
                SizedBox(height: 10.h),
                // Add to Cart button
                SizedBox(
                  width: double.infinity,
                  height: 35.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.primary,
                      foregroundColor: appColors.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
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
