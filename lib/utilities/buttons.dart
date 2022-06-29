import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  final String platform;
  final Color color;
  final dynamic onTap;
  Color? fontColor = Colors.black;

  LoginButton({
    Key? key,
    required this.platform,
    required this.color,
    required this.onTap,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: color,
          ),
          width: 50,
          height: 50,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                  'assets/images/${platform.toLowerCase()}_logo.png'),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class StretchedButton extends StatelessWidget {
  Color color;
  String title;
  Color titleColor;
  dynamic onTap;
  double height;
  double width;
  double fontSize;
  double borderRadius;
  bool showElevation;

  StretchedButton({
    Key? key,
    this.color = Palette.basicBlue,
    required this.title,
    required this.onTap,
    this.titleColor = Colors.white,
    this.height = 50,
    this.width = 0,
    this.fontSize = 18,
    this.borderRadius = 8,
    this.showElevation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: showElevation ? 2 : 0,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(borderRadius),
      color: color,
      child: InkWell(
        child: SizedBox(
          height: height.h,
          width: width == 0 ? Get.width : width.w,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize.sp,
                color: titleColor,
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ColoredOutlinedButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color outlineColor;
  final dynamic onTap;
  final double height;
  final double width;

  const ColoredOutlinedButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.color,
    this.outlineColor = Colors.grey,
    this.height = 45,
    this.width = 180,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          side: MaterialStateProperty.all(BorderSide(color: outlineColor)),
        ),
        child: SizedBox(
          width: width.w,
          height: height.h,
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: color),
            ),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
