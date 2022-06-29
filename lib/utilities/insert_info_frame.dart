import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsertInfoFrame extends StatelessWidget {
  String title;
  Widget content;
  double height;
  double fontSize;
  bool showBorder;
  bool isOptional;
  MainAxisAlignment alignment;
  InsertInfoFrame({
    Key? key,
    required this.title,
    required this.content,
    this.height = 45,
    this.fontSize = 14,
    this.showBorder = true,
    this.alignment = MainAxisAlignment.spaceBetween,
    this.isOptional = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          SizedBox(
            height: height.h,
            width: 70.w,
            child: Center(
              child: isOptional
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Text(
                          '(선택)',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 12),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(fontSize: fontSize.sp),
                    ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: height.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: showBorder ? Colors.grey : Colors.transparent,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: content,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
