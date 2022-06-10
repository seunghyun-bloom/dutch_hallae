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
      child: SizedBox(
        width: 350,
        child: ElevatedButton(
          child: ListTile(
            leading:
                Image.asset('assets/images/${platform.toLowerCase()}_logo.png'),
            title: Text(
              '$platform로 시작하기',
              style: TextStyle(color: fontColor),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}

class StretchedButton extends StatelessWidget {
  Color color;
  String title;
  dynamic onTap;

  StretchedButton({
    Key? key,
    required this.color,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
          child: SizedBox(
            height: 50.h,
            width: Get.width,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
