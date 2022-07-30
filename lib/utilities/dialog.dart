import 'dart:io';

import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DialogByPlatform {
  String title;
  String content;
  String rightLabel;
  String leftLabel;
  dynamic onTap;
  dynamic onLeftTap;
  BuildContext context;
  DialogByPlatform(
      {required this.title,
      required this.content,
      this.rightLabel = '예',
      this.leftLabel = '아니오',
      required this.onTap,
      this.onLeftTap,
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
                    child: Text(rightLabel),
                    onPressed: onTap,
                  ),
                  CupertinoDialogAction(
                    child: Text(leftLabel),
                    onPressed: onLeftTap ?? () => Get.back(),
                  ),
                ],
              );
            },
          )
        : showAnimatedDialog(
            barrierDismissible: true,
            context: context,
            animationType: DialogTransitionType.scale,
            duration: const Duration(milliseconds: 300),
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.all(10),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 38.h),
                      child: Text(content),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: StretchedButton(
                                color: Colors.grey,
                                title: leftLabel,
                                height: 40,
                                fontSize: 14,
                                onTap: onLeftTap),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: StretchedButton(
                              color: Palette.basicBlue,
                              title: rightLabel,
                              height: 40,
                              fontSize: 14,
                              onTap: onTap,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
  }
}
