import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zalada_flutter/modules/authentication/change_password/page/change_password_page.dart';
import 'package:zalada_flutter/modules/authentication/login/pages/login_page.dart';
import 'package:zalada_flutter/modules/orders/presenter/address_page.dart';
import 'package:zalada_flutter/modules/orders/presenter/payment_method_page.dart';
import 'package:zalada_flutter/modules/profile/models/model_language.dart';
import 'package:zalada_flutter/modules/profile/presenter/about_page.dart';
import 'package:zalada_flutter/modules/profile/presenter/edite_profile_page.dart';
import 'package:zalada_flutter/modules/profile/presenter/order_history_page.dart';
import 'package:zalada_flutter/modules/profile/presenter/privacy_policy_page.dart';
import 'package:zalada_flutter/modules/profile/widgets/item_language.dart';
import 'package:zalada_flutter/modules/profile/widgets/item_profile.dart';
import 'package:zalada_flutter/modules/profile/widgets/my_profile.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_dialog.dart';

import '../../../gen/assets.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitched = true;
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: AppSpacing.xxlg),
            Text(
              'Profile',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                context.push(EditeProfilePage.routePath);
              },
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kColorGray500.withOpacity(0.4),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: -4.0,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Assets.svg.edit.svg(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: MyProfile(
                imageUrl:
                    'https://static.vecteezy.com/system/resources/thumbnails/008/846/297/small_2x/cute-boy-avatar-png.png',
                name: 'Chorn THOEN',
                email: 'thoenchorn@gmail.com',
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.kPrimaryColor,
                        ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Column(
                      children: [
                        ItemProfile(
                          title: 'Address',
                          icon: IconlyLight.location,
                          onPressed: () {
                            context.push(AddressPage.routePath);
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'Payment Method',
                          icon: PhosphorIconsRegular.creditCard,
                          onPressed: () {
                            context.push(PaymentMethodPage.routePath);
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'History',
                          icon: IconlyLight.timeSquare,
                          onPressed: () {
                            context.push(OrderHistoryPage.routePath);
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'Notification',
                          icon: IconlyLight.notification,
                          onPressed: () {},
                          trailing: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                            activeColor: AppColors.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'General',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.kPrimaryColor,
                        ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Column(
                      children: [
                        ItemProfile(
                          title: 'Change Language',
                          icon: PhosphorIconsLight.globe,
                          onPressed: () {
                            selectLanguage();
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'Change Password',
                          icon: PhosphorIconsRegular.password,
                          onPressed: () {
                            context.push(ChangePasswordPage.routePath);
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'Help & Support',
                          icon: PhosphorIconsLight.question,
                          onPressed: () {
                            context.push(PrivacyPolicyPage.routePath);
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'Privacy Policy',
                          icon: PhosphorIconsRegular.lockKey,
                          onPressed: () {
                            context.push(PrivacyPolicyPage.routePath);
                          },
                        ),
                        const CustomDivider(),
                        ItemProfile(
                          title: 'About Us',
                          icon: PhosphorIconsRegular.info,
                          onPressed: () {
                            context.push(AboutPage.routePath);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ItemProfile(
                    title: 'Logout',
                    icon: IconlyLight.logout,
                    onPressed: () {
                      CustomDialog.showDialogCustom(
                        context,
                        title: 'Logout',
                        content: 'Are you sure you want to logout?',
                        ok: () => context.go(LoginPage.routePath),
                        okText: 'Logout',
                      );
                    },
                    color: AppColors.kRedColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select Language',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                ...List.generate(
                  listLanguage.length,
                  (index) => ItemLanguage(
                    name: listLanguage[index].name,
                    logo: listLanguage[index].logo,
                    onPressed: () {
                      setState(() {
                        if (listLanguage[index].isSelect == true) {
                          for (var element in listLanguage) {
                            element.isSelect = false;
                          }
                        } else {
                          for (var element in listLanguage) {
                            element.isSelect = false;
                          }
                          listLanguage[index].isSelect = true;
                        }
                      });
                      Navigator.pop(context);
                    },
                    isSelect: listLanguage[index].isSelect,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
