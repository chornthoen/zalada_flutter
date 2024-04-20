import 'package:flutter/material.dart';
import 'package:khqr_widget/khqr_widget.dart';
import 'package:zalada_flutter/shared/spacing/app_spacing.dart';
import 'package:zalada_flutter/shared/widgets/custom_app_bar.dart';

class PaymentKHQRCodePage extends StatefulWidget {
  const PaymentKHQRCodePage({super.key});

  static const routePath = "/payment-kHQRCode";

  @override
  State<PaymentKHQRCodePage> createState() => _PaymentKHQRCodePageState();
}

class _PaymentKHQRCodePageState extends State<PaymentKHQRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "KHQR Code"),
      body: Column(
        children: [
          SizedBox(height: AppSpacing.xlg),
          KhqrWidget(
            width: 320,
            receiverName: "Chorn THOEN",
            amount: "25.00",
            currency: "USD",
            qr: "https://github.com/chornthoen",
            qrIcon: Image.asset(
              "assets/images/khr.png",
              height: 16,
              width: 16,
            ),
          ),
        ],
      ),
    );
  }
}
