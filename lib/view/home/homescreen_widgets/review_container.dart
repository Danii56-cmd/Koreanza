import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  static const _reviews = [
    {
      'review':
          'My skin has never felt so soft and hydrated. The Glow Serum is a literal game changer!',
      'name': 'Sarah J.',
    },
    {
      'review':
          'Absolutely love this product! My skin glows every morning after using it.',
      'name': 'Emma R.',
    },
    {
      'review':
          'Best serum I have ever tried. Worth every penny, highly recommend!',
      'name': 'Mia K.',
    },
    {
      'review':
          'I noticed a difference in just 3 days. My skin feels so much smoother.',
      'name': 'Lina P.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Horizontal list
        SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              final item = _reviews[index];
              return Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: ReviewContainer(
                  review: item['review']!,
                  name: item['name']!,
                  imagePath: AppConstants.profile,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Review card
class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    super.key,
    required this.review,
    required this.name,
    required this.imagePath,
    this.rating = 5,
  });

  final String review;
  final String name;
  final String imagePath;
  final int rating;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(14.r),
      width: 250.w,
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: appColors.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              rating,
              (_) => Icon(Icons.star, color: appColors.primary, size: 14.r),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            review,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              color: appColors.title,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 28.r,
                  height: 28.r,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                name,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: appColors.title,
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
