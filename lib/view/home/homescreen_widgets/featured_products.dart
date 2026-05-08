import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final _scrollController = ScrollController();

  static const _products = [
    {
      'name': 'Glow Serum Luxe',
      'price': '\$42.00',
      'subtitle': 'Ultra Hydrating',
    },
    {'name': 'Velvet Mist', 'price': '\$38.00', 'subtitle': 'Sensitive Skin'},
    {'name': 'Rose Elixir', 'price': '\$55.00', 'subtitle': 'Anti-Aging'},
    {'name': 'Hydra Boost', 'price': '\$29.00', 'subtitle': 'Deep Moisture'},
  ];

  void _scroll(bool toRight) {
    final offset = toRight
        ? (_scrollController.offset + 180.w).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          )
        : (_scrollController.offset - 180.w).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          );
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: appColors.title,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
              Row(
                children: [
                  _NavButton(
                    icon: Icons.chevron_left,
                    appColors: appColors,
                    onTap: () => _scroll(false),
                  ),
                  SizedBox(width: 6.w),
                  _NavButton(
                    icon: Icons.chevron_right,
                    appColors: appColors,
                    onTap: () => _scroll(true),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 14.h),

        // Horizontal product list
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _products.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              final product = _products[index];
              return _ProductCard(
                name: product['name']!,
                price: product['price']!,
                subtitle: product['subtitle']!,
                appColors: appColors,
              );
            },
          ),
        ),
      ],
    );
  }
}

// Nav arrow button
class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.appColors,
    required this.onTap,
  });

  final IconData icon;
  final AppColors appColors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 20.r, color: appColors.primary),
    );
  }
}

// Product card
class _ProductCard extends StatefulWidget {
  const _ProductCard({
    required this.name,
    required this.price,
    required this.subtitle,
    required this.appColors,
  });

  final String name;
  final String price;
  final String subtitle;
  final AppColors appColors;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.appColors;

    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 14.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: c.title.withValues(alpha: 0.08),
            blurRadius: 16.r,
            offset: Offset(0, 4.r),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + heart
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Image.asset(
                  AppConstants.glow,
                  // color: c.primary.withValues(alpha: 0.2),
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Pink gradient overlay at bottom of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          c.primary.withValues(alpha: 0.08),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
              // Tappable heart with toggle
              Positioned(
                top: 8.r,
                right: 8.r,
                child: GestureDetector(
                  onTap: () => setState(() => _isFav = !_isFav),
                  child: Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      color: c.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: c.title.withValues(alpha: 0.1),
                          blurRadius: 6.r,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isFav ? Icons.favorite : Icons.favorite_border,
                      size: 16.r,
                      color: _isFav ? Colors.red : c.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Text + button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + price on same row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: c.title,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: c.primary,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: c.subtitle,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
                SizedBox(height: 10.h),
                // Add to Cart button
                SizedBox(
                  width: double.infinity,
                  height: 35.h,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      size: 13.r,
                      // color: c.title,
                    ),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.secondary,
                      foregroundColor: c.subtitle,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.zero,
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
