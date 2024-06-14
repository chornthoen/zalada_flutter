import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zalada_flutter/gen/assets.gen.dart';
import 'package:zalada_flutter/modules/product/presenter/product_detail_page.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';

import '../shared/widgets/number_animated.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    required this.onDelete,
    required this.selected,
    required this.onDecrement,
    required this.onIncrement,
    this.onSelected,
    this.index,
  });

  final String imageUrl;
  final String title;
  final double price;
  final double originalPrice;
  final int quantity;
  final Function() onDelete;
  final Function(bool? value)? onSelected;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final bool selected;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
        left: AppSpacing.md,
        right: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kColorGray200,
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                splashRadius: AppSpacing.lg,
                activeColor: AppColors.kPrimaryColor,
                side: BorderSide(
                  color: AppColors.kColorGray500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                ),
                value: selected,
                onChanged: onSelected,
              ),
              InkWell(
                onTap: () {
                  context.push(ProductDetailPage.routePath);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.kColorGray100,
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        NumberTotalAnimate(total: price.toString()),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '\$$originalPrice',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: onDecrement,
                              child: Container(
                                padding:
                                    const EdgeInsets.all(AppSpacing.xs + 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.kColorGray300,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: -2.0,
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  PhosphorIcons.minus(),
                                  size: AppSpacing.lg + 2,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            NumberAnimated(quantity: quantity),
                            const SizedBox(width: AppSpacing.md),
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: onIncrement,
                              child: Container(
                                padding:
                                    const EdgeInsets.all(AppSpacing.xs + 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.kColorGray300,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: -2.0,
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  PhosphorIcons.plus(),
                                  size: AppSpacing.lg + 2,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // delete button
                        InkWell(
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                          onTap: onDelete,
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.sm),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kRedColor.withOpacity(0.3),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -4.0,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Assets.svg.delete.svg(
                              color: AppColors.kRedColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.lg),
            ],
          ),
        ],
      ),
    );
  }
}
