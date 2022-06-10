import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogByPlatform {
  String title;
  String content;
  String? leftLabel;
  String? rightLabel;
  final onTap;
  final onRightTap;
  BuildContext context;
  DialogByPlatform(
      {required this.title,
      required this.content,
      this.leftLabel = '예',
      this.rightLabel = '아니오',
      required this.onTap,
      this.onRightTap,
      required this.context}) {
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  CupertinoDialogAction(
                    child: Text(leftLabel!),
                    onPressed: onTap,
                  ),
                  CupertinoDialogAction(
                    child: Text(rightLabel!),
                    onPressed: onRightTap ?? () => Get.back(),
                  ),
                ],
              );
            },
          )
        : showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    child: Text(leftLabel!),
                    onPressed: onTap,
                  ),
                  TextButton(
                    child: Text(rightLabel!),
                    onPressed: onRightTap ?? () => Get.back(),
                  ),
                ],
              );
            },
          );
  }
}
