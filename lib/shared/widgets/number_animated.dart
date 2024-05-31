import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';

class NumberAnimated extends StatelessWidget {
  const NumberAnimated({
    super.key,
    required this.quantity,
    this.color = AppColors.kBlackColor,
  });

  final int quantity;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCounter(
      duration: const Duration(milliseconds: 300),
      value: double.parse(quantity.toString()),
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
    );
  }
}

class NumberTotalAnimate extends StatelessWidget {
  const NumberTotalAnimate({
    super.key,
    required this.total,
    this.color = AppColors.kPrimaryColor,
    this.label,
  });
  final String total;
  final Color? color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label ?? '\$',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            total,
            key: ValueKey<double>(double.parse(total)),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kPrimaryColor,
                ),
          ),
        ),
      ],
    );
  }
}

class AnimationFlipCounter extends StatelessWidget {
  const AnimationFlipCounter({
    super.key,
    required this.total,
    this.color = AppColors.kPrimaryColor,
    this.label,
  });
  final String total;
  final Color? color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label ?? '\$',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
        ),
        AnimatedFlipCounter(
          fractionDigits: 2,
          duration: const Duration(milliseconds: 700),
          value: double.parse(total),
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.kPrimaryColor,
              ),
        ),
      ],
    );
  }
}
