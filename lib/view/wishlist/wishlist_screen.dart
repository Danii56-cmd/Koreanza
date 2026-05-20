import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/models/products_model.dart';
import 'package:koreanza/providers/wishlist_provider.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/view/productdetails/product_details_screen.dart';
import 'package:koreanza/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final products = wishlist.items;

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
          leadingWidth: 30.w,
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
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                /// HEADER
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
                          "${wishlist.count} Items",
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

                /// EMPTY STATE
                if (products.isEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 250.h,
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 60.sp,
                            color: appColors.primary,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "No items in wishlist yet",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: appColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Wrap(
                    spacing: 14.w,
                    runSpacing: 14.h,
                    children: products
                        .map(
                          (p) => SizedBox(
                            width: cardWidth,
                            child: WishlistProductCard(product: p),
                          ),
                        )
                        .toList(),
                  ),

                SizedBox(height: 20.h),
                // If No Products Added To Wishlist
                if (products.isNotEmpty) ...[
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// WishList Product card
class WishlistProductCard extends StatelessWidget {
  final ProductModel product;

  const WishlistProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final wishlist = context.watch<WishlistProvider>();

    final isFav = wishlist.isWishlisted(product.id);
    final p = product;

    return Container(
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: appColors.subtitle.withValues(alpha: 0.07),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE + BADGE + HEART
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: p),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Image.asset(
                    p.image,
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// BADGE
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

              /// HEART (CONNECTED TO PROVIDER)
              Positioned(
                top: 8.r,
                right: 8.r,
                child: GestureDetector(
                  onTap: () {
                    context.read<WishlistProvider>().toggleWishlist(p);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
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
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 16.r,
                      color: isFav ? appColors.iconColor : appColors.iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// CONTENT
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// RATING
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

                /// NAME
                Text(
                  p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.title,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),

                SizedBox(height: 2.h),

                /// SUBTITLE
                Text(
                  p.subtitle,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: appColors.subtitle,
                    height: 1.4,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),

                SizedBox(height: 8.h),

                /// PRICE
                Text(
                  "K${p.price}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: appColors.primary,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),

                SizedBox(height: 10.h),

                /// ADD TO CART
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
