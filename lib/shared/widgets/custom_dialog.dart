import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zalada_flutter/shared/colors/app_color.dart';

class CustomDialog {
  static void showDialogCustom(
    BuildContext context, {
    required Function() ok,
    Function()? cancel,
    required String title,
    required String content,
    String? cancelText,
    required String? okText,
    bool? isConfirm = true,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    if (cancel != null) {
                      cancel();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    cancelText ?? 'Cancel',
                    style: TextStyle(
                      color: isConfirm! ? Colors.black : AppColors.kRedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: ok,
                  child: Text(
                    okText!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isConfirm! ? Colors.red : AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () {
                    if (cancel != null) {
                      cancel();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    cancelText ?? 'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: ok,
                  child: Text(
                    okText!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isConfirm! ? Colors.red : AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
