import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogByPlatform {
  String title;
  String content;
  final onTap;
  BuildContext context;
  DialogByPlatform(
      {required this.title,
      required this.content,
      required this.onTap,
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
                    child: Text('예'),
                    onPressed: onTap,
                  ),
                  CupertinoDialogAction(
                    child: Text('아니오'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              );
            })
        : showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    child: const Text('예'),
                    onPressed: onTap,
                  ),
                  TextButton(
                    child: const Text('아니오'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              );
            });
  }
}
