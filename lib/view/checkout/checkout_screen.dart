import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/models/cart_model.dart';
import 'package:koreanza/providers/cart_provider.dart';
import 'package:koreanza/providers/order_provider.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/sharedwidgets/custombutton.dart';
import 'package:koreanza/view/orderhistory/order_history_screen.dart';
import 'package:koreanza/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final int subtotal;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String _selectedPayment = 'Cash on Delivery';
  final List<_PaymentOption> _paymentOptions = const [
    _PaymentOption(
      label: 'Cash on Delivery',
      icon: Icons.money_outlined,
    ),
    _PaymentOption(
      label: 'Credit / Debit Card',
      icon: Icons.credit_card_outlined,
    ),
    _PaymentOption(
      label: 'Easypaisa',
      icon: Icons.phone_android_outlined,
    ),
  ];

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;

    final orderProvider = context.read<OrderProvider>();
    final cartProvider = context.read<CartProvider>();

    orderProvider.placeOrder(
      cartItems: widget.cartItems,
      subtotal: widget.subtotal,
      fullName: nameController.text.trim(),
      address: addressController.text.trim(),
      city: cityController.text.trim(),
      phone: phoneController.text.trim(),
      paymentMethod: _selectedPayment,
    );

    cartProvider.clearCart();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
    );
  }

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),

        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      'Secure Checkout',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily:
                            GoogleFonts.plusJakartaSans().fontFamily,
                        color: appColors.title,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// SHIPPING INFORMATION
                    _SectionCard(
                      appColors: appColors,
                      icon: Icons.local_shipping_outlined,
                      title: 'Shipping Information',
                      child: Column(
                        children: [
                          _buildField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: nameController,
                            appColors: appColors,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Full name is required'
                                : null,
                          ),
                          SizedBox(height: 12.h),
                          _buildField(
                            label: 'Street Address',
                            hint: 'House #, Street, Area',
                            controller: addressController,
                            appColors: appColors,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Address is required'
                                : null,
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: _buildField(
                                  label: 'City',
                                  hint: 'City',
                                  controller: cityController,
                                  appColors: appColors,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                          ? 'Required'
                                          : null,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildField(
                                  label: 'Phone',
                                  hint: '+92...',
                                  controller: phoneController,
                                  appColors: appColors,
                                  keyboardType: TextInputType.phone,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Required';
                                    }
                                    if (v.trim().length < 10) {
                                      return 'Invalid number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// PAYMENT METHOD
                    _SectionCard(
                      appColors: appColors,
                      icon: Icons.payment_outlined,
                      title: 'Payment Method',
                      child: Column(
                        children: _paymentOptions.map((option) {
                          final isSelected =
                              _selectedPayment == option.label;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPayment = option.label),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(bottom: 10.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? appColors.primary.withValues(alpha: 0.08)
                                    : appColors.bg,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: isSelected
                                      ? appColors.primary
                                      : appColors.border,
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    option.icon,
                                    color: isSelected
                                        ? appColors.primary
                                        : appColors.subtitle,
                                    size: 20.r,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      option.label,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: isSelected
                                            ? appColors.title
                                            : appColors.subtitle,
                                        fontFamily:
                                            GoogleFonts.plusJakartaSans()
                                                .fontFamily,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: appColors.primary,
                                      size: 18.r,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// ORDER SUMMARY
                    _CheckoutOrderSummary(
                        appColors: appColors, widget: widget),

                    SizedBox(height: 24.h),

                    /// PLACE ORDER BUTTON
                    CustomButton(
                      text: 'Place Order',
                      onPressed: _placeOrder,
                      buttonColor: appColors.iconColor,
                      icon: Icons.lock,
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required AppColors appColors,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: appColors.title,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            fontSize: 14.sp,
            color: appColors.title,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: appColors.subtitle.withValues(alpha: 0.6),
              fontSize: 13.sp,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: appColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: appColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Payment option data class ────────────────────────────────────────────────

class _PaymentOption {
  final String label;
  final IconData icon;
  const _PaymentOption({required this.label, required this.icon});
}

// ─── Reusable section card ────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final AppColors appColors;
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.appColors,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: appColors.iconColor, size: 20.r),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: appColors.title,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }
}

// ─── Order Summary Card ───────────────────────────────────────────────────────

class _CheckoutOrderSummary extends StatelessWidget {
  final AppColors appColors;
  final CheckoutScreen widget;

  const _CheckoutOrderSummary({
    required this.appColors,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: appColors.title,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
          SizedBox(height: 12.h),

          /// ITEMS LIST
          ...widget.cartItems.map((item) {
            final product = item.product;
            final qty = item.qty;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Container(
                    height: 72.h,
                    width: 72.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: appColors.border,
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        fit: BoxFit.cover,
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
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: appColors.title,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          '${product.subtitle}  •  Qty: $qty',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: appColors.subtitle,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'PKR ${product.price * qty}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: appColors.primary,
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          Divider(color: appColors.border, thickness: 1),
          SizedBox(height: 8.h),

          _summaryRow('Subtotal', 'PKR ${widget.subtotal}', appColors),
          SizedBox(height: 4.h),
          _summaryRow('Shipping', 'Free', appColors,
              valueColor: Colors.green[700]),
          SizedBox(height: 4.h),
          _summaryRow('Estimated Tax', 'PKR 50', appColors),

          SizedBox(height: 10.h),
          Divider(color: appColors.border, thickness: 1),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: appColors.title,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
              Text(
                'PKR ${widget.subtotal + 50}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: appColors.primary,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, AppColors appColors,
      {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: appColors.subtitle,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: valueColor ?? appColors.title,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
        ),
      ],
    );
  }
}
