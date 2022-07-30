import 'package:dotted_border/dotted_border.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'styles.dart';

class NoDataSquare extends StatelessWidget {
  final String titleString;
  final String contentString;
  final dynamic onTap;
  final bool showButton;
  final String buttonTitle;
  final Color borderColor;
  final bool isCrying;

  const NoDataSquare({
    Key? key,
    required this.titleString,
    required this.contentString,
    required this.onTap,
    this.showButton = false,
    this.buttonTitle = '',
    this.borderColor = Colors.grey,
    this.isCrying = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: DottedBorder(
        color: borderColor,
        borderType: BorderType.RRect,
        radius: const Radius.circular(6),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: Get.width * 0.9,
            width: Get.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    height: Get.width * 0.3,
                    width: Get.width * 0.3,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(isCrying
                            ? 'assets/images/no_data.png'
                            : 'assets/images/profile_sample_6.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      titleString,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Text(
                    contentString,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  showButton
                      ? Container(
                          margin: EdgeInsets.only(top: 20.h),
                          width: 200.w,
                          child: StretchedButton(
                            title: buttonTitle,
                            fontSize: 15.sp,
                            height: 45.h,
                            onTap: onTap,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
