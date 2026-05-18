import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/models/products_model.dart';
import 'package:koreanza/providers/cart_provider.dart';
import 'package:koreanza/providers/product_providers.dart';
import 'package:koreanza/providers/wishlist_provider.dart';
import 'package:koreanza/view/productdetails/product_details_screen.dart';
import 'package:provider/provider.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final ScrollController _scrollController = ScrollController();

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
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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

        // PRODUCT LIST
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: EdgeInsets.only(left: 20.w),
            itemBuilder: (context, index) {
              final product = products[index];

              return _ProductCard(product: product, appColors: appColors);
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
class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.appColors});

  final ProductModel product;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final isFav = wishlist.isWishlisted(product.id);
    final c = appColors;

    return Padding(
      padding: EdgeInsets.only(right: 14.w),
      child: Container(
        width: 200.w,
        margin: EdgeInsets.only(bottom: 20.h),
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
            // IMAGE + HEART
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductDetailsScreen(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    child: Image.asset(
                      AppConstants.glow,
                      height: 170.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // HEART BUTTON (PROVIDER)
                Positioned(
                  top: 8.r,
                  right: 8.r,
                  child: GestureDetector(
                    onTap: () {
                      context.read<WishlistProvider>().toggleWishlist(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFav
                                ? "Removed from wishlist"
                                : "Added to wishlist",
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
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
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 16.r,
                        color: isFav
                            ? appColors.iconColor
                            : appColors.iconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // TEXT INFO
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME + PRICE
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: c.title,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                      ),
                      Text(
                        "Pkr ${product.price}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: c.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    product.subtitle,
                    style: TextStyle(fontSize: 11.sp, color: c.subtitle),
                  ),
                  SizedBox(height: 10.h),

                  // ADD TO CART
                  SizedBox(
                    width: double.infinity,
                    height: 35.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartProvider>().addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product.name} added to cart"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_bag_outlined, size: 13.r),
                      label: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: c.secondary,
                        foregroundColor: c.subtitle,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
