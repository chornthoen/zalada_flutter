import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zalada_flutter/modules/profile/presenter/order_history_detail_page.dart';
import 'package:zalada_flutter/modules/profile/widgets/item_view_orders.dart';
import 'package:zalada_flutter/shared/widgets/custom_app_bar.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  static const routePath = '/order-history';

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order History'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              2,
              (index) => ItemViewOrders(
                onTap: () {
                  context.push(OrderHistoryDetailPage.routePath);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
