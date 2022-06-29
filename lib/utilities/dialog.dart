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
  String leftLabel;
  String rightLabel;
  dynamic onTap;
  dynamic onRightTap = () => Get.back();
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
                    child: Text(leftLabel),
                    onPressed: onTap,
                  ),
                  CupertinoDialogAction(
                    child: Text(rightLabel),
                    onPressed: onRightTap,
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
                                title: rightLabel,
                                height: 40,
                                fontSize: 14,
                                onTap: onRightTap),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: StretchedButton(
                              color: Palette.basicBlue,
                              title: leftLabel,
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
