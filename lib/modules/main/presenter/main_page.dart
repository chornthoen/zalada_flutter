import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zalada_flutter/components/bottom_nav_item.dart';
import 'package:zalada_flutter/gen/assets.gen.dart';
import 'package:zalada_flutter/modules/home/presenter/home_page.dart';
import 'package:zalada_flutter/modules/profile/presenter/profile_page.dart';
import 'package:zalada_flutter/modules/wishlist/presenter/wishlist_page.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';

import '../../cart/presenter/cart_page.dart';
import '../../search/presenter/search_page.dart';

late PageController pageController;
late ScrollController scrollController;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const routePath = '/main-page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin<MainPage> {
  int selectedIndex = 0;

  final _pages = [
    const HomePage(),
    const SearchPage(),
    const WishListPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  final bottomNavItems = [
    {
      'icon': Assets.svg.homeLight.path,
      'iconSelected': Assets.svg.homeBulk.path,
      'label': 'Home',
    },
    {
      'icon': Assets.svg.searchLight.path,
      'iconSelected': Assets.svg.searchBulk.path,
      'label': 'Search',
    },
    {
      'icon': Assets.svg.heartLight.path,
      'iconSelected': Assets.svg.heartBulk.path,
      'label': 'Wishlist',
      'badge': true,
    },
    {
      'icon': Assets.svg.buyLight.path,
      'iconSelected': Assets.svg.buyBulk.path,
      'label': 'Cart',
      'badge': true,
    },
    {
      'icon': Assets.svg.profileLight.path,
      'iconSelected': Assets.svg.profileBulk.path,
      'label': 'Profile',
    },
  ];

  bool isDeviceConnected = false;
  bool isAlertSet = false;
  late StreamSubscription listener;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        print('Disconnected');
        showDialogBox();
      } else if (status == InternetConnectionStatus.connected) {
        print('Connected');
      }
    });
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    listener.cancel();
    // scrollController.dispose();
    super.dispose();
  }

  Future<void> showDialogBox() async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connectivity'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              if (!(await InternetConnectionChecker().hasConnection)) {
                showDialogBox();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        reverse: true,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: AppColors.kWhiteColor,
        color: AppColors.kWhiteColor,
        padding: EdgeInsets.zero,
        height: Platform.isIOS ? 65 : 75,
        child: Padding(
          padding: EdgeInsets.only(
            right: 10,
            left: 10,
            top: 10,
            bottom: Platform.isIOS ? 1 : 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              bottomNavItems.length,
              (index) {
                final item = bottomNavItems[index];
                return BottomNavItem(
                  icon: item['icon'] as String,
                  iconSelected: item['iconSelected'] as String,
                  selected: selectedIndex == index,
                  label: item['label'] as String,
                  badgeCount: item['badge'] == true && index == 3 ? 2 : 0,
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.slowMiddle);
                      pageController.jumpToPage(index);
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
