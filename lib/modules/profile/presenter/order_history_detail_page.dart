import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zalada_flutter/components/lazy_list_view.dart';
import 'package:zalada_flutter/modules/orders/widgets/item_card.dart';
import 'package:zalada_flutter/modules/orders/widgets/item_order.dart';
import 'package:zalada_flutter/modules/product/widgets/payment_add_to_cart.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_app_bar.dart';

class OrderHistoryDetailPage extends StatefulWidget {
  const OrderHistoryDetailPage({super.key});

  static const routePath = '/order-history-detail';

  @override
  State<OrderHistoryDetailPage> createState() => _OrderHistoryDetailPageState();
}

class _OrderHistoryDetailPageState extends State<OrderHistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order History Detail'),
      body: LazyListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSpacing.lg),
                ItemOrder(
                  title: 'Apple Watch Series 9 GPS 45mm',
                  image:
                      'https://powermaccenter.com/cdn/shop/files/Apple_Watch_Series_9_GPS_45mm_Silver_Aluminum_Storm_Blue_Sport_Band_PDP_Image_Position-1__en-US_8d562dcd-6b02-4975-8a24-26b210107cec_1445x.jpg?v=1699527146',
                  price: 1999.00,
                  originalPrice: 2499.00,
                  quantity: 1,
                  index: 1,
                ),
              ],
            ),
          ),
          Divider(color: AppColors.kColorGray200, thickness: AppSpacing.xs),
          // shipping
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.truck(),
                              color: Theme.of(context).primaryColor,
                              size: AppSpacing.xlg,
                            ),
                            SizedBox(width: AppSpacing.md),
                            Text(
                              'J&T Express',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Spacer(),
                            Icon(
                              PhosphorIcons.caretRight(),
                              color: Colors.black,
                              size: AppSpacing.xlg,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Text(
                      'Delivery Time',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                    Text(
                      'Today, 10:00 AM - 12:00 PM',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      'Delivery Fee',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                    Text(
                      '\$0.00',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.kColorGray200,
            thickness: AppSpacing.xs,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                PaymentAddToCart(
                  label: 'Subtotal',
                  value: 3998.00,
                ),
                PaymentAddToCart(
                  label: 'Shipping Fee',
                  value: 30.00,
                ),
                PaymentAddToCart(
                  label: 'Discount',
                  value: -100.00,
                ),
                PaymentAddToCart(
                  label: 'Total',
                  value: 3998.00,
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.kColorGray200,
            thickness: AppSpacing.xs,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                ItemCard(
                  name: 'Mastercard',
                  image: 'assets/images/mastercard.png',
                  code: '**** **** 1234',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
