import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'styles.dart';

class NoDataSquare extends StatelessWidget {
  const NoDataSquare(
      {Key? key,
      required this.titleString,
      required this.contentString,
      required this.onTap})
      : super(key: key);
  final String titleString;
  final String contentString;
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
            // height: Get.height * 0.3,
            width: Get.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Pantone.veryPeri,
                    ),
                    height: Get.width * 0.3,
                    width: Get.width * 0.3,
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
                      titleString,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    contentString,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
