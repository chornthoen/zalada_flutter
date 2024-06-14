import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zalada_flutter/components/promotion_slider.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({
    super.key,
  });

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 160,
            viewportFraction: 0.9,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          items: List.generate(
            3,
            (index) => Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: PromotionSlider(),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => dotIndicator(index),
          ),
        ),
      ],
    );
  }

  Widget dotIndicator(int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: current == index ? 1 : 0.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: current == index ? AppSpacing.xxxlg : AppSpacing.sm,
        height: AppSpacing.sm - 2,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
          color: current == index
              ? AppColors.kPrimaryColor
              : AppColors.kColorGray500,
        ),
        curve: Curves.easeInOut,
      ),
    );
  }
}
