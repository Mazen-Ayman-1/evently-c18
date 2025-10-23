import 'dart:io';

import 'package:evently_c16_mon/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialogsUtils {
  // loading dialog
  static Future<void> showLoadingDialog({
    required BuildContext context,
    required String loadingMessage,
    bool dismissible = true,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        var content = Row(
          children: [
            Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
            SizedBox(width: 8),
            Text(loadingMessage),
          ],
        );
        if (Platform.isIOS) {
          return CupertinoAlertDialog(content: content);
        }
        return AlertDialog(content: content);
      },
    );
  }

  // action dialog
  static Future<void> showActionDialog({
    required BuildContext context,
    bool dismissible = true,
    String? title,
    String? content,
    String? posActionTitle,
    Function()? posAction,
    String? negActionTitle,
    Function()? negAction,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        List<Widget>? actions =
            posActionTitle == null && negActionTitle == null ? null : [];

        if (posActionTitle != null) {
          actions?.add(
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (posAction != null) {
                  posAction();
                }
              },
              child: Text(
                posActionTitle,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          );
        }

        if (negActionTitle != null) {
          actions?.add(
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (negAction != null) {
                  negAction();
                }
              },
              child: Text(
                negActionTitle,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          );
        }

        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: content != null ? Text(content) : null,
            actions: actions ?? [],
          );
        }
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: actions ?? [],
        );
      },
    );
  }
}
