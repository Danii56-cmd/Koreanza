import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/models/shopproducts_model.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/view/productdetails/product_details_screen.dart';
import 'package:koreanza/view/profile/profile_screen.dart';

// Sample data
final List<Product> _products = [
  Product(
    name: 'Dewy Petal Essence',
    subtitle: 'Hydrating Glow\nSerum',
    price: 'Pkr 999',
    rating: 4.9,
    image: AppConstants.shopIcon1,
    badge: 'BEST SELLER',
    badgeColor: Color(0xFFFF6B8A),
  ),
  Product(
    name: 'Cloud Whipped Cream',
    subtitle: 'Ceramide\nMoisturizer',
    price: 'Pkr 999',
    rating: 4.8,
    image: AppConstants.shopIcon2,
  ),
  Product(
    name: 'Velvet Rose Cleanser',
    subtitle: 'Gentle Foaming\nWash',
    price: 'Pkr 999',
    rating: 4.7,
    image: AppConstants.shopIcon3,
    badge: 'ECO-CHOICE',
    badgeColor: Color(0xFF4CAF50),
  ),
  Product(
    name: 'Moonlight Night Oil',
    subtitle: 'Restorative Elixir',
    price: 'Pkr 999',
    rating: 5.0,
    image: AppConstants.shopIcon4,
  ),
];

// ShoppingScreen
class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

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
          actionsPadding: EdgeInsets.only(right: 10.w),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search skincare essentials...',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.black38),
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(color: appColors.secondary),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Curated Collection + Refine
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Curated Collection",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: appColors.title,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: appColors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune,
                            color: appColors.subtitle,
                            size: 14.r,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Refine",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: appColors.subtitle,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(label: "Skin Type: All"),
                      SizedBox(width: 8.w),
                      _FilterChip(label: "Concern: Glow"),
                      SizedBox(width: 8.w),
                      _FilterChip(label: "Price: Under \$50"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Product grid via Wrap
                Wrap(
                  spacing: 14.w,
                  runSpacing: 14.h,
                  children: _products
                      .map(
                        (p) => SizedBox(
                          width: cardWidth,
                          child: ProductCard(product: p),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Filter chip
class _FilterChip extends StatelessWidget {
  final String label;
  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: appColors.secondary.withValues(alpha: 0.2),
        border: Border.all(
          color: appColors.secondary.withValues(alpha: 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: appColors.subtitle,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Product card
class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
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
