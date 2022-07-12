import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_color_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_friends_selector.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_image_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_name_writer.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupAddPage extends GetView<GroupController> {
  GroupAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 추가'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GroupImagePicker(),
                  GroupNameWriter(),
                  GroupColorPicker(),
                  GroupFriendsSelector(),
                ],
              ),
              StretchedButton(
                color: Palette.basicBlue,
                title: '등록하기',
                onTap: () => DialogByPlatform(
                  title: '모임 등록',
                  content: '새 모임을 등록하시겠습니까?',
                  context: context,
                  onTap: () async {
                    Get.back();
                    Get.back();
                    Loading(context);
                    await controller.uploadGroupFirebase();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
