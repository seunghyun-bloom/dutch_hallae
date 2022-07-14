import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniProfile extends StatelessWidget {
  ImageProvider image;
  String name;
  MiniProfile({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 2.h, 4.w, 2.h),
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: image,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 2.w),
            Text(
              name,
              style: TextStyle(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
