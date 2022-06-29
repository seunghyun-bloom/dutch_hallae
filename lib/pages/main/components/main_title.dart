import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentsTitle extends StatelessWidget {
  String title;
  String subTitle;
  dynamic onTap;
  ContentsTitle({
    Key? key,
    required this.title,
    required this.onTap,
    this.subTitle = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
            TextButton(
              child: const Text('더보기 >'),
              onPressed: onTap,
            ),
          ],
        ),
        subTitle == ''
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(subTitle),
              ),
      ],
    );
  }
}
