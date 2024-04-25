import 'package:flutter/material.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';
import 'package:zalada_flutter/shared/widgets/utils.dart';

class CustomAnimateBorder extends CustomPainter {
  CustomAnimateBorder(this.animationPercent);

  final double animationPercent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.5
      ..color = AppColors.kPrimaryColor
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..lineTo(size.width - 10, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 10)
      ..lineTo(size.width, size.height / 2);

    final path2 = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(0, size.height - 10)
      ..quadraticBezierTo(0, size.height, 10, size.height)
      ..lineTo(size.width - 10, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - 10)
      ..lineTo(size.width, size.height / 2);

    final p1 = Utils.createAnimatedPath(path, animationPercent);
    final p2 = Utils.createAnimatedPath(path2, animationPercent);

    canvas
      ..drawPath(p1, paint)
      ..drawPath(p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
