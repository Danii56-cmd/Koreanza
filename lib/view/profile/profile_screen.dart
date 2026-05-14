import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/core/app_constants.dart';
import 'package:koreanza/services/tab_navigation_service.dart'; // Ensure this path is correct

class ProfileScreen extends StatefulWidget {
  final bool isTab;
  const ProfileScreen({super.key, this.isTab = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool emailNotifications = true;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);

    return Scaffold(
      backgroundColor: appColors.bg,
      appBar: AppBar(
        backgroundColor: appColors.bg,
        centerTitle: false,
        elevation: 0.5,
        shadowColor: appColors.subtitle.withValues(alpha: 0.3),
        leadingWidth: 30.w,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.primary),
          onPressed: () {
            if (widget.isTab) {
              TabNavigationService.instance.switchTab(0);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        titleSpacing: 0,
        title: Text(
          "Account Settings",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: appColors.primary,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: appColors.primary),
            onPressed: () {},
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // --- Profile Header ---
            _buildProfileHeader(appColors),
            SizedBox(height: 30.h),
            // --- Personal Information ---
            _buildSectionHeader(
              Icons.person_outline,
              "PERSONAL INFORMATION",
              appColors,
            ),
            _buildCardContainer(appColors, [
              _buildInputField("Full Name", "Kainat Akhtar", appColors),
              SizedBox(height: 16.h),
              _buildInputField(
                "Email Address",
                "kainatakhtar@gmail.com",
                appColors,
              ),
            ]),
            SizedBox(height: 24.h),
            // --- Security ---
            _buildSectionHeader(Icons.shield_outlined, "SECURITY", appColors),
            _buildCardContainer(appColors, [
              _buildInputField(
                "Current Password",
                "••••••••••••",
                appColors,
                isPassword: true,
              ),
              SizedBox(height: 12.h),
              _buildInputField(
                "New Password",
                "Enter new password",
                appColors,
                isPassword: true,
              ),
              SizedBox(height: 12.h),
              _buildInputField(
                "Confirm New Password",
                "Repeat new password",
                appColors,
                isPassword: true,
              ),
            ]),
            SizedBox(height: 24.h),
            // --- Preferences ---
            _buildSectionHeader(Icons.tune, "PREFERENCES", appColors),
            _buildCardContainer(appColors, [
              _buildSwitchTile(
                "Email Notifications",
                "Weekly skin tips, product launches",
                emailNotifications,
                (val) => setState(() => emailNotifications = val),
                appColors,
              ),
              Divider(height: 24.h, color: appColors.border),
              _buildSwitchTile(
                "Push Notifications",
                "Instant order updates",
                pushNotifications,
                (val) => setState(() => pushNotifications = val),
                appColors,
              ),
            ]),
            SizedBox(height: 40.h),
            // --- Action Buttons ---
            _buildButton(
              "Save Changes",
              appColors.primary,
              appColors.surface,
              appColors,
            ),
            SizedBox(height: 12.h),
            _buildButton(
              "Sign Out",
              appColors.secondary,
              appColors.primary,
              appColors,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // --- Helper Components using your AppColors class ---

  Widget _buildProfileHeader(AppColors appColors) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: appColors.secondary,
              backgroundImage: Image.asset(AppConstants.profile).image,
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: appColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: appColors.card, width: 2),
                ),
                child: Icon(Icons.edit, color: appColors.surface, size: 14.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          "Kainat Akhtar",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: appColors.title,
          ),
        ),
        Text(
          "Korenza Member",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: appColors.subtitle,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(IconData icon, String title, AppColors appColors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: appColors.primary),
          SizedBox(width: 8.w),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: appColors.primary,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContainer(AppColors appColors, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: appColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInputField(
    String label,
    String value,
    AppColors appColors, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: appColors.title,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: value,
          obscureText: isPassword,
          style: TextStyle(color: appColors.title, fontSize: 14.sp),
          decoration: InputDecoration(
            filled: true,
            fillColor: appColors.bg.withValues(alpha: 0.3),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: appColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: appColors.border),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    AppColors appColors,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: appColors.title,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.sp,
                  color: appColors.subtitle,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          // ignore: deprecated_member_use
          activeColor: appColors.primary,
        ),
      ],
    );
  }

  Widget _buildButton(
    String label,
    Color bg,
    Color textColor,
    AppColors appColors,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        onPressed: () {},
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
