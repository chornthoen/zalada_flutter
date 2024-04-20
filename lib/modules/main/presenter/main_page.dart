import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zalada_flutter/components/bottom_nav_item.dart';
import 'package:zalada_flutter/modules/home/presenter/home_page.dart';
import 'package:zalada_flutter/modules/profile/presenter/profile_page.dart';
import 'package:zalada_flutter/modules/wishlist/presenter/wishlist_page.dart';

import '../../cart/presenter/cart_page.dart';
import '../../search/presenter/search_page.dart';

late PageController pageController;

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
      'icon': PhosphorIcons.houseSimple(),
      'label': 'Home',
    },
    {
      'icon': PhosphorIcons.magnifyingGlass(),
      'label': 'Search',
    },
    {
      'icon': PhosphorIcons.heart(),
      'label': 'Wishlist',
      'badge': true,
    },
    {
      'icon': PhosphorIcons.shoppingBag(),
      'label': 'Cart',
      'badge': true,
    },
    {
      'icon': PhosphorIcons.user(),
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
  }

  @override
  void dispose() {
    listener.cancel();
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
        surfaceTintColor: Colors.white,
        color: Colors.white,
        padding: EdgeInsets.zero,
        height: Platform.isIOS ? 65 : 75,
        child: Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            top: 10,
            bottom: Platform.isIOS ? 0 : 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              bottomNavItems.length,
              (index) {
                final item = bottomNavItems[index];
                return BottomNavItem(
                  icon: item['icon'] as IconData,
                  selected: selectedIndex == index,
                  label: item['label'] as String,
                  badgeCount: item['badge'] == true && index == 3 ? 2 : 0,
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
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
