import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zalada_flutter/components/cart_item_card.dart';
import 'package:zalada_flutter/components/lazy_list_view.dart';
import 'package:zalada_flutter/modules/cart/models/cart_models.dart';
import 'package:zalada_flutter/modules/cart/presenter/cart_empty_page.dart';
import 'package:zalada_flutter/modules/cart/widgets/custom_checkout_button.dart';
import 'package:zalada_flutter/modules/orders/presenter/orders_page.dart';
import 'package:zalada_flutter/modules/wishlist/widgets/product_card.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_dialog.dart';

import '../../wishlist/models/product_wishlist.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  final key = GlobalKey<AnimatedListState>();

  @override
  bool get wantKeepAlive => true;

  void removeItems(int index) {
    final removeList = cartItems.removeAt(index);
    key.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: CartItemCard(
          imageUrl: removeList.imageUrl,
          title: removeList.title,
          price: removeList.price,
          originalPrice: removeList.originalPrice,
          quantity: removeList.quantity,
          onDelete: () {},
          selected: removeList.selected,
          onDecrement: () {},
          onIncrement: () {},
          onSelected: (value) {},
        ),
      ),
    );
    setState(() {});
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double total = 0;

  double calculateTotalPrice() {
    total = 0;
    for (var item in cartItems) {
      if (item.selected) {
        total += item.price;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    total = calculateTotalPrice();
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.kPrimaryColor,
              ),
        ),
      ),
      body: LazyListView(
        children: [
          if (cartItems.isEmpty) const CartEmptyPage(),
          if (cartItems.isNotEmpty) ...[
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
                  value: cartItems.every((element) => element.selected),
                  onChanged: (value) {
                    setState(() {
                      for (var item in cartItems) {
                        item.selected = value!;
                      }
                    });
                  },
                ),
                Text(
                  'Select All products',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
          AnimatedList(
            key: key,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index, animation) {
              final item = cartItems[index];
              return CartItemCard(
                imageUrl: item.imageUrl,
                title: item.title,
                price: item.price,
                originalPrice: item.originalPrice,
                quantity: item.quantity,
                onDelete: () {
                  // removeItems(index);
                  _confirmDelete(index);
                },
                selected: item.selected,
                onDecrement: () {
                  setState(() {
                    if (item.quantity > 1) {
                      item.price = item.price / item.quantity;
                      item.quantity--;
                    }
                  });
                },
                onIncrement: () {
                  setState(() {
                    item.quantity++;
                    item.price = item.price * item.quantity;
                  });
                },
                onSelected: (value) {
                  setState(() {
                    item.selected = value!;
                  });
                },
              );
            },
            initialItemCount: cartItems.length,
          ),
          const SizedBox(height: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.lg,
                  bottom: AppSpacing.lg,
                ),
                child: Text(
                  'Related Products',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productWishlist.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      size: AppSpacing.lg,
                      title: productWishlist[index].title,
                      image: productWishlist[index].image,
                      status: productWishlist[index].status,
                      originalPrice: productWishlist[index].originalPrice,
                      salePrice: productWishlist[index].salePrice,
                      type: productWishlist[index].type,
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.xlg),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: cartItems.where((element) => element.selected).isNotEmpty
                ? 60
                : 0,
            child: Wrap(
              children: [
                CustomCheckoutButton(
                  total: total.toString(),
                  quantity:
                      cartItems.where((element) => element.selected).length,
                  onPressed: () {
                    context.push(OrdersPage.routePath);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(int index) async {
    CustomDialog.showDialogCustom(
      context,
      title: 'Delete Product',
      content: 'Are you sure you want to delete this item?',
      ok: () {
        removeItems(index);
        Navigator.of(context).pop();
      },
      okText: 'Delete',
    );
  }
}
