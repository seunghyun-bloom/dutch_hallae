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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black87),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: image,
          ),
          SizedBox(width: 5.w),
          Text(
            name,
            style: TextStyle(fontSize: 17.sp),
          ),
        ],
      ),
    );
  }
}
