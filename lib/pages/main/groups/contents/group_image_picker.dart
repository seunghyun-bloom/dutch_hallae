import 'dart:io';

import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/contents/insert_frame.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GroupImagePicker extends GetView<GroupController> {
  const GroupImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return InsertGroupInfoFrame(
      title: '대표사진',
      content: Center(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Obx(
            () => controller.isSample.value
                ? ModifiableAvatar(
                    image: AssetImage(controller.pickedImage.value),
                  )
                : ModifiableAvatar(
                    image: FileImage(File(controller.pickedImage.value)),
                  ),
          ),
          onTap: () => DialogByPlatform(
            title: '모임 사진',
            content: '어디에서 불러오시겠습니까?',
            leftLabel: '사진첩',
            onTap: () => controller.getGroupImage(ImageSource.gallery),
            rightLabel: '카메라',
            onRightTap: () => controller.getGroupImage(ImageSource.camera),
            context: context,
          ),
        ),
      ),
    );
  }
}
