import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';

class ItemProfile extends StatelessWidget {
  const ItemProfile({
    required this.title,
    required this.icon,
    this.onPressed,
    this.trailing,
    super.key,
    this.color,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
        foregroundColor: color ?? AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
        ),
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                  // color: color ?? AppColors.kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: color ?? AppColors.kPrimaryColor,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: -4.0,
                      blurRadius: 10.0,
                    ),
                  ],
                  // gradient: LinearGradient(
                  //   colors: [
                  //     color ?? AppColors.kPrimaryColor.withOpacity(0.6),
                  //     color ?? AppColors.kPrimaryColor,
                  //   ],
                  // ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: color ?? Colors.black,
                    ),
              ),
              const Spacer(),
              trailing ??
                  Icon(
                    IconlyLight.arrowRight2,
                    color: color ?? Colors.grey,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      color: AppColors.kColorGray300,
    );
  }
}
