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
                      color: isConfirm ? Colors.red : AppColors.kPrimaryColor,
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

// class CustomAlertDialog {
//   static void customAlert(
//       BuildContext context, {
//         required VoidCallback? onOk,
//         required String title,
//         required String content,
//         required String okText,
//         String? cancelText,
//         VoidCallback? onClose,
//         IconData? icon,
//       }) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '',
//       transitionDuration: const Duration(milliseconds: 300),
//       pageBuilder: (context, animation1, animation2) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: AlertDialog(
//             backgroundColor: AppColors.kWhiteColor,
//             contentPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppSpacing.md),
//             ),
//             content: Container(
//               padding: const EdgeInsets.all(AppSpacing.lg),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(AppSpacing.md),
//                 color: AppColors.kWhiteColor,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(AppSpacing.sm),
//                         decoration: BoxDecoration(
//                           color: AppColors.kPrimaryColor,
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.kPrimaryColor.withOpacity(0.5),
//                               AppColors.kPrimaryColor,
//                             ],
//                           ),
//                         ),
//                         child: Icon(
//                           icon,
//                           color: AppColors.kWhiteColor,
//                           size: 20,
//                         ),
//                       ),
//                       const SizedBox(width: AppSpacing.sm),
//                       Text(
//                         title,
//                         style:
//                         Theme.of(context).textTheme.headlineSmall!.copyWith(
//                           color: AppColors.kBlackColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: AppSpacing.md),
//                   Text(
//                     content,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       color: AppColors.kColorBlack,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(height: AppSpacing.xlg),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: FilledButtonTonalCustom(
//                           text: cancelText ?? 'Close',
//                           onPressed:
//                           onClose ?? () => Navigator.of(context).pop(),
//                         ),
//                       ),
//                       const SizedBox(width: AppSpacing.md),
//                       Expanded(
//                         child: FilledButtonCustom(
//                           text: okText,
//                           onPressed: onOk,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
