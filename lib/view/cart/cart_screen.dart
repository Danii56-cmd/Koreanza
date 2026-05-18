import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koreanza/core/app_colors.dart';
import 'package:koreanza/models/products_model.dart';
import 'package:koreanza/providers/cart_provider.dart';
import 'package:koreanza/sharedwidgets/custom_drawer.dart';
import 'package:koreanza/sharedwidgets/custom_popscope.dart';
import 'package:koreanza/view/checkout/checkout_screen.dart';
import 'package:koreanza/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

// // Sample cart data using the shared Product model
// final List<Map<String, dynamic>> _cartItems = [
//   {
//     'product': ProductModel(
//       id: "1",
//       name: 'Radiance Dew Serum',
//       subtitle: '30ml • Vitality Boost',
//       price: 'Pkr 999',
//       rating: 4.9,
//       image: AppConstants.cartIcon1,
//     ),
//     'qty': 1,
//   },
//   {
//     'product': ProductModel(
//       id: "2",
//       name: 'Cloud Whip Cream',
//       subtitle: '50g • Intense Hydration',
//       price: 'Pkr 999',
//       rating: 4.8,
//       image: AppConstants.cartIcon2,
//     ),
//     'qty': 2,
//   },
//   {
//     'product': ProductModel(
//       id: "3",
//       name: 'Pure Petal Cleanser',
//       subtitle: 'Gentle Foaming Wash',
//       price: 'Pkr 999',
//       rating: 4.7,
//       image: AppConstants.cartIcon3,
//     ),
//     'qty': 1,
//   },
// ];

// CartScreen
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final List<Map<String, dynamic>> _items = List.from(_cartItems);

  // int get _totalItems => _items.fold(0, (sum, e) => sum + (e['qty'] as int));

  // int get _totalPrice => _items.fold(0, (sum, e) {
  //   final raw = (e['product'] as ProductModel).price.replaceAll(
  //     RegExp(r'[^0-9]'),
  //     '',
  //   );
  //   return sum + (int.tryParse(raw) ?? 0) * (e['qty'] as int);
  // });

  // void _changeQty(int index, int delta) {
  //   setState(() {
  //     final newQty = (_items[index]['qty'] as int) + delta;
  //     if (newQty < 1) {
  //       _items.removeAt(index);
  //     } else {
  //       _items[index] = {..._items[index], 'qty': newQty};
  //     }
  //   });
  // }

  // void _removeItem(int index) => setState(() => _items.removeAt(index));

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final items = cartProvider.items;

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

        // Body
        body: items.isEmpty
            ? _EmptyCart(appColors: appColors)
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Text(
                                "Your Cart",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: appColors.title,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  "${cartProvider.totalItems} ITEMS",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: appColors.subtitle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Cart item list
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => SizedBox(height: 14.h),
                            itemBuilder: (_, i) => CartItemCard(
                              product: items[i].product,
                              qty: items[i].qty,
                              appColors: appColors,
                              onIncrement: () =>
                                  cartProvider.increaseQty(items[i].product.id),
                              onDecrement: () =>
                                  cartProvider.decreaseQty(items[i].product.id),
                              onDelete: () =>
                                  cartProvider.removeItem(items[i].product.id),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          SummaryCard(subtotal: cartProvider.totalPrice),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                  // Order Summary
                  _OrderSummary(
                    // totalPrice: cartProvider.totalPrice,
                    // cartItems: items,
                  ),
                ],
              ),
      ),
    );
  }
}

// CartItemCard
class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.product,
    required this.qty,
    required this.appColors,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  final ProductModel product;
  final int qty;
  final AppColors appColors;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: appColors.border, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              product.image,
              width: 90.w,
              height: 90.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: appColors.title,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onDelete,
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: appColors.iconColor,
                        size: 15.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  product.subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: appColors.subtitle,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pkr ${product.price}",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: appColors.primary,
                      ),
                    ),
                    // Pill-shaped Stepper
                    Container(
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: appColors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: appColors.border),
                      ),
                      child: Row(
                        children: [
                          _StepperBtn(icon: Icons.remove, onTap: onDecrement),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              "$qty",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: appColors.title,
                              ),
                            ),
                          ),
                          _StepperBtn(icon: Icons.add, onTap: onIncrement),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepperBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Icon(icon, size: 16.sp, color: appColors.primary),
      ),
    );
  }
}

// Order Summary bar
class SummaryCard extends StatelessWidget {
  final int subtotal;

  const SummaryCard({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return Container(
      // Padding and Margin to match the image spacing
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: appColors.border, width: 1.2),
      ),
      child: Column(
        children: [
          // Subtotal Row
          _buildRow("SUBTOTAL", "PKR $subtotal", context),
          SizedBox(height: 20.h),

          // Shipping Row
          _buildRow("SHIPPING", "CALCULATED AT NEXT STEP", context),
          SizedBox(height: 20.h),

          // Free Shipping Banner
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: appColors.secondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: appColors.border, width: 1.2),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  color: appColors.primary,
                  size: 22.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "You're 9,999rs away from FREE SHIPPING",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: appColors.subtitle,
                      fontWeight: FontWeight.w500,
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

  Widget _buildRow(String label, String value, BuildContext context) {
    final appColors = AppColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: appColors.title,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 12.sp, color: appColors.title),
        ),
      ],
    );
  }
}

// Order Summary Widget
class _OrderSummary extends StatelessWidget {
  const _OrderSummary();

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: [
          BoxShadow(
            color: appColors.surface.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL AMOUNT",
                    style: TextStyle(fontSize: 10.sp, color: appColors.title),
                  ),
                  Text(
                    "PKR ${cartProvider.totalPrice}",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      color: appColors.primary,
                    ),
                  ),
                ],
              ),

              Text(
                "Includes all taxes",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: appColors.title,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          SizedBox(
            width: 270.w,
            height: 50.h,
            child: ElevatedButton(
              onPressed: cartProvider.items.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            cartItems: cartProvider.items,
                            subtotal: cartProvider.totalPrice,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CHECKOUT NOW",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: appColors.surface,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward, color: appColors.surface),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Empty cart state
class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.appColors});
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 72.r,
            color: appColors.subtitle.withValues(alpha: 0.4),
          ),
          SizedBox(height: 16.h),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: appColors.title,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            "Add something beautiful",
            style: TextStyle(fontSize: 13.sp, color: appColors.subtitle),
          ),
        ],
      ),
    );
  }
}
