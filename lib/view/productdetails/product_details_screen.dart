import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/view/home/homescreen_widgets/review_container.dart';
import 'package:koreanza/view/profile/profile_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

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
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 350.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.productImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 320.w,
                    margin: EdgeInsets.only(top: 320.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 30.h,
                    ),
                    decoration: BoxDecoration(
                      color: appColors.bg,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: appColors.border, width: 1.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tags and Price Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTag(
                              "BEST SELLER",
                              appColors.secondary,
                              appColors.subtitle,
                            ),
                            SizedBox(width: 8.w),
                            _buildTag("VEGAN", Colors.green[50]!, Colors.green),
                            const Spacer(),
                            Text(
                              "PKR 999",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appColors.primary,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "Luminous\nGlow Serum",
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: appColors.title,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: appColors.iconColor,
                              size: 16,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                                color: appColors.title,
                              ),
                            ),
                            Text(
                              "  •  ",
                              style: TextStyle(
                                color: appColors.subtitle,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              "124 reviews",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                                color: appColors.subtitle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Unlock a radiant, lit-from-within complexion with our signature Luminous Glow Serum. Formulated with stabilized Vitamin C and hyaluronic acid to brighten, hydrate, and refine skin texture instantly.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: appColors.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: appColors.bg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  border: Border(
                    top: BorderSide(color: appColors.border, width: 1.w),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          fixedSize: Size(150.w, 30.h),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: appColors.surface,
                            ),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.plusJakartaSans().fontFamily,
                                color: appColors.surface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Key Benifits",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        color: appColors.title,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BenifitsContainer(
                          appColors: appColors,
                          icon: Icons.wb_sunny_outlined,
                          text: "Instant Glow",
                        ),
                        // SizedBox(width: 10.w),
                        BenifitsContainer(
                          appColors: appColors,
                          icon: Icons.water_drop_outlined,
                          text: "Deep\nHydration",
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BenifitsContainer(
                          appColors: appColors,
                          icon: Icons.auto_fix_high,
                          text: "Pore\nRefinement",
                        ),
                        // SizedBox(width: 10.w),
                        BenifitsContainer(
                          appColors: appColors,
                          icon: Icons.verified_outlined,
                          text: "Barrier Support",
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appColors.surface,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: appColors.border, width: 1.w),
                        boxShadow: [
                          BoxShadow(
                            color: appColors.border.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ingredients",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      GoogleFonts.plusJakartaSans().fontFamily,
                                  color: appColors.title,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Divider(color: appColors.border, thickness: 1.w),
                          SizedBox(height: 15.h),
                          // Description
                          Text(
                            "A powerful blend of clean, dermatologically tested actives.",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily:
                                  GoogleFonts.plusJakartaSans().fontFamily,
                              color: appColors.subtitle,
                              height: 1.4, // Adds line spacing
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Wrap(
                            spacing: 8.w, // Horizontal space between chips
                            runSpacing: 8.h, // Vertical space between lines
                            children: [
                              _buildIngredientChip("Vitamin C", appColors),
                              _buildIngredientChip(
                                "Hyaluronic Acid",
                                appColors,
                              ),
                              _buildIngredientChip("Niacinamide", appColors),
                              _buildIngredientChip("Rosehip Oil", appColors),
                              _buildIngredientChip("Peptides", appColors),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appColors.surface,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: appColors.border, width: 1.w),
                        boxShadow: [
                          BoxShadow(
                            color: appColors.border.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Vital for nested lists
                        children: [
                          // Header Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "How to Use",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      GoogleFonts.plusJakartaSans().fontFamily,
                                  color: appColors.title,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Divider(color: appColors.border, thickness: 1.w),
                          SizedBox(height: 15.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final steps = [
                                {
                                  "title": "Cleanse",
                                  "desc":
                                      "Start with a freshly cleansed and slightly damp face.",
                                },
                                {
                                  "title": "Apply",
                                  "desc":
                                      "Dispense 2-3 drops into palms and gently press onto skin.",
                                },
                                {
                                  "title": "Seal",
                                  "desc":
                                      "Follow with your favorite moisturizer to lock in the glow.",
                                },
                              ];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Circular Step Number
                                    Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                        color: appColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: appColors.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    // Text Content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            steps[index]["title"]!,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: appColors.title,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            steps[index]["desc"]!,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: appColors.subtitle,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Complete the Ritual",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: appColors.title,
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: appColors.iconColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Complete The Ritual
                    CompleteTheRitual(),
                    SizedBox(height: 15.h),
                    // Review Section
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: appColors.title,
                          ),
                        ),
                        Text(
                          "Write a Review",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: appColors.iconColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ReviewSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BenifitsContainer extends StatelessWidget {
  const BenifitsContainer({
    super.key,
    required this.appColors,
    required this.icon,
    required this.text,
  });

  final AppColors appColors;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 140.w,
      decoration: BoxDecoration(
        color: appColors.secondary.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: appColors.iconColor, size: 24),
          SizedBox(height: 5.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: appColors.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTag(String text, Color bgColor, Color textColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildIngredientChip(String label, dynamic appColors) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: appColors.secondary.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: appColors.border.withValues(alpha: 0.5),
        width: 1.w,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: appColors.subtitle,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class CompleteTheRitual extends StatelessWidget {
  CompleteTheRitual({super.key});

  final List<Map<String, String>> _products = [
    {
      'name': 'Velvet Cleanser',
      'price': 'PKr 999',
      'image': AppConstants.ritualProduct1,
    },
    {
      'name': 'Dewy Moisturizer',
      'price': 'PKr 999',
      'image': AppConstants.ritualProduct2,
    },
    {
      'name': 'Radiance Elixir',
      'price': 'PKr 999',
      'image': AppConstants.ritualProduct3,
    },
    {
      'name': 'Hydra Burst Mask',
      'price': 'PKr 999',
      'image': AppConstants.ritualProduct4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return SizedBox(
      height: 280.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _products.length,
        padding: EdgeInsets.only(bottom: 8.h),
        itemBuilder: (context, index) {
          final product = _products[index];
          return _RitualCard(
            name: product['name']!,
            price: product['price']!,
            appColors: appColors,
            image: product['image']!,
          );
        },
      ),
    );
  }
}

class _RitualCard extends StatelessWidget {
  const _RitualCard({
    required this.name,
    required this.price,
    required this.appColors,
    required this.image,
  });

  final String name;
  final String price;
  final AppColors appColors;
  final String image;

  @override
  Widget build(BuildContext context) {
    final c = appColors;

    return Container(
      width: 170.w,
      margin: EdgeInsets.only(right: 14.w),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: c.border, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: c.title.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.r),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Image.asset(
              image,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Name + Price
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: c.title,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: c.primary,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
