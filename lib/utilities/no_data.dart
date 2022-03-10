import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'styles.dart';

class NoData extends StatelessWidget {
  const NoData(
      {Key? key,
      required this.subject,
      required this.object,
      required this.onTap})
      : super(key: key);
  final String subject;
  final String object;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(6),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 240.h,
            width: Get.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Pantone.veryPeri,
                  ),
                  height: 100,
                  width: 100,
                  child: const Center(
                    child: Text(
                      '캐릭터',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '$object 추가해주세요',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  '아직 등록된 $subject 없으시네요',
                ),
                Text(
                  '$object 추가해주세요',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
