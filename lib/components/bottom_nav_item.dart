import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.selected = false,
    this.badgeCount = 0,
    required this.iconSelected,
  });

  final String icon;
  final String iconSelected;
  final String label;
  final VoidCallback onPressed;
  final bool selected;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 70,
          minHeight: 70,
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            boxShadow: [
              BoxShadow(
                color: selected ? AppColors.kPrimaryColor : Colors.transparent,
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: -8.0,
                blurRadius: 12.0,
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: 10.0,
                blurRadius: 20.0,
                offset: const Offset(-40, -30),
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: 10.0,
                blurRadius: 20.0,
                offset: const Offset(10, -20),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                badgeCount > 0
                    ? Badge(
                        offset: const Offset(8, -5),
                        label: Text(
                          badgeCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: SvgPicture.asset(
                          selected ? iconSelected : icon,
                          colorFilter: selected
                              ? const ColorFilter.mode(
                                  AppColors.kPrimaryColor,
                                  BlendMode.srcIn,
                                )
                              : ColorFilter.mode(
                                  AppColors.kColorGray500,
                                  BlendMode.srcIn,
                                ),
                          width: 24,
                          height: 24,
                        ),
                      )
                    : SvgPicture.asset(
                        selected ? iconSelected : icon,
                        colorFilter: selected
                            ? const ColorFilter.mode(
                                AppColors.kPrimaryColor,
                                BlendMode.srcIn,
                              )
                            : ColorFilter.mode(
                                AppColors.kColorGray500,
                                BlendMode.srcIn,
                              ),
                        width: 24,
                        height: 24,
                      ),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    color: selected
                        ? AppColors.kPrimaryColor
                        : AppColors.kColorGray600,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    fontSize: selected ? 12.5 : 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
