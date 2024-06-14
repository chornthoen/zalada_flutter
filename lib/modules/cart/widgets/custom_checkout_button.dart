import 'package:flutter/material.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/number_animated.dart';

class CustomCheckoutButton extends StatelessWidget {
  const CustomCheckoutButton({
    super.key,
    required this.total,
    this.onPressed,
    this.quantity,
  });

  final String total;
  final int? quantity;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: AppColors.kWhiteColor,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        children: [
          AnimationFlipCounter(
            label: 'Total: \$',
            total: total,
          ),
          const Spacer(),
          InkWell(
            splashColor: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxxlg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Row(
                children: [
                  Text(
                    'Checkout',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.only(left: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.kGreyColor,
                      shape: BoxShape.circle,
                    ),
                    child: NumberAnimated(
                      quantity: quantity!,
                      color: AppColors.kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
