import 'dart:io';

import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecordImagePicker extends GetView<RecordController> {
  const RecordImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    return Center(
      child: Obx(
        () => SizedBox(
          width: Get.mediaQuery.size.width * 0.9,
          height: Get.mediaQuery.size.width * 0.9,
          child: controller.pickedImage.value == ''
              ? NoDataSquare(
                  titleString: '사진을 등록해보세요',
                  contentString: '친구들과 함께한 추억을 기록할 수 있습니다!',
                  borderColor: Palette.basicBlue,
                  isCrying: false,
                  onTap: () => DialogByPlatform(
                    title: '모임 사진',
                    content: '어디에서 불러오시겠습니까?',
                    rightLabel: '사진첩',
                    onTap: () => controller.getImage(ImageSource.gallery),
                    leftLabel: '카메라',
                    onLeftTap: () => controller.getImage(ImageSource.camera),
                    context: context,
                  ),
                )
              : InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(controller.pickedImage.value),
                    ),
                  ),
                  onTap: () => DialogByPlatform(
                    title: '모임 사진',
                    content: '어디에서 불러오시겠습니까?',
                    rightLabel: '사진첩',
                    onTap: () => controller.getImage(ImageSource.gallery),
                    leftLabel: '카메라',
                    onLeftTap: () => controller.getImage(ImageSource.camera),
                    context: context,
                  ),
                ),
        ),
      ),
    );
  }
}
