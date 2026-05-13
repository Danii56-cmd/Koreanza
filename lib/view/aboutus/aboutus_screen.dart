import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: appColors.primary),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(
            "Koreanza",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: appColors.primary,
              fontStyle: FontStyle.italic,
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
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Philosophy Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OUR PHILOSOPHY",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: appColors.primary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                          color: appColors.title,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "Koreanza was born from a belief that skin should ",
                          ),
                          TextSpan(
                            text: "glow",
                            style: TextStyle(
                              color: appColors.primary,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              fontFamily:
                                  GoogleFonts.plusJakartaSans().fontFamily,
                            ),
                          ),
                          const TextSpan(text: ", not hide."),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "We celebrate the radiance of natural beauty by formulating high-performance skincare that works in harmony with your biology.",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: appColors.subtitle,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const IngredientsContainer(
                      text: "Clean Ingredients",
                      icon: FontAwesomeIcons.leaf,
                    ),
                    const IngredientsContainer(
                      text: "Cruelty-Free",
                      icon: FontAwesomeIcons.paw,
                    ),
                    const IngredientsContainer(
                      text: "Dermatologist Tested",
                      icon: FontAwesomeIcons.circleCheck,
                    ),
                    SizedBox(height: 24.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        AppConstants.aboutUs1,
                        width: double.infinity,
                        height: 280.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              // Science of Glow Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40.h),
                color: appColors.secondary.withValues(alpha: 0.15),
                child: Column(
                  children: [
                    Text(
                      "The Science of Glow",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: appColors.title,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Pure botanical extracts meets clinical\nprecision.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: appColors.subtitle,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Ingredient Card 1: Rosehip Oil
                    _ScienceCard(
                      title: "Rosehip Oil",
                      description:
                          "Rich in essential fatty acids and antioxidants, rosehip oil regenerates skin cells and reduces the appearance of scars.",
                      imagePath: AppConstants.aboutUs2,
                      appColors: appColors,
                      badges: const ["Vitamin A & C Infused", "Deep Hydration"],
                    ),

                    // Ingredient Card 2: Vitamin C
                    _ScienceCard(
                      title: "Vitamin C",
                      description:
                          "A stable, non-irritating form that brightens skin tone and neutralizes free radicals for a luminous finish.",
                      imagePath: AppConstants.aboutUs3,
                      appColors: appColors,
                    ),

                    // Ingredient Card 3: Hyaluronic Acid
                    _ScienceCard(
                      title: "Hyaluronic Acid",
                      description:
                          "Multiple molecular weights work across different layers of the dermis to lock in moisture and plump fine lines instantly.",
                      imagePath: AppConstants.aboutUs4,
                      appColors: appColors,
                      isLast: true,
                    ),
                  ],
                ),
              ),

              // Values Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                child: Column(
                  children: [
                    _ValueItem(
                      icon: Icons.biotech,
                      title: "Dermatologist Formulated",
                      description:
                          "Every formula is vetted by leading experts to ensure safety for sensitive skin types.",
                      appColors: appColors,
                    ),
                    SizedBox(height: 40.h),
                    _ValueItem(
                      icon: Icons.volunteer_activism,
                      title: "Always Cruelty-Free",
                      description:
                          "We never test on animals and ensure our entire supply chain maintains these ethical standards.",
                      appColors: appColors,
                    ),
                    SizedBox(height: 40.h),
                    _ValueItem(
                      icon: Icons.park,
                      title: "Earth Conscious",
                      description:
                          "Recyclable packaging and sustainable sourcing practices for a beautiful planet.",
                      appColors: appColors,
                    ),
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

class _ScienceCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final dynamic appColors;
  final List<String>? badges;
  final bool isLast;

  const _ScienceCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.appColors,
    this.badges,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: appColors.title.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Image.asset(
              imagePath,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: appColors.title,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    color: appColors.subtitle,
                    height: 1.5,
                  ),
                ),
                if (badges != null) ...[
                  SizedBox(height: 12.h),
                  ...badges!.map(
                    (b) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14.sp,
                            color: appColors.primary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            b,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: appColors.subtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isLast)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Center(
                child: SizedBox(
                  width: 200.w,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.iconColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Discover The\nScience",
                      style: TextStyle(
                        color: appColors.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ValueItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final dynamic appColors;

  const _ValueItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: appColors.secondary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24.sp, color: appColors.primary),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
            color: appColors.title,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: appColors.subtitle,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class IngredientsContainer extends StatelessWidget {
  final String text;
  final FaIconData icon;
  const IngredientsContainer({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: appColors.secondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 12.sp, color: appColors.subtitle),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: appColors.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
