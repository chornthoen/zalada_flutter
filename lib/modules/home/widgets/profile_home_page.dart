import 'package:flutter/material.dart';
import 'package:zalada_flutter/gen/assets.gen.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';

class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({
    super.key,
    required this.name,
    required this.image,
    required this.cartCount,
    required this.notificationCount,
    required this.onCartPressed,
    required this.onNotificationPressed,
    required this.onProfilePressed,
  });

  final String name;
  final String image;
  final int cartCount;
  final int notificationCount;
  final VoidCallback onCartPressed;
  final VoidCallback onNotificationPressed;
  final VoidCallback onProfilePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onProfilePressed,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    image,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello 👋',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onCartPressed,
                child: Badge(
                  label: Text(
                    cartCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kColorGray400,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: -2.0,
                          blurRadius: 12.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Assets.svg.buyBulk.svg(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              GestureDetector(
                onTap: onNotificationPressed,
                child: Badge(
                  label: Text(
                    notificationCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: AppColors.kColorGray300,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kColorGray400,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: -2.0,
                          blurRadius: 12.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Assets.svg.notifications.svg(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
