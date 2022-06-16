import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_color_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_friends_selector.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_image_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_name_writer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupAddPage extends StatelessWidget {
  GroupAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 추가'),
        actions: [
          TextButton(
            child: const Text('print'),
            onPressed: () {
              print(Get.find<GroupController>().writedName);
              print(Get.find<GroupController>().pickedColor);
              print(Get.find<GroupController>().pickedImage);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              GroupImagePicker(),
              GroupNameWriter(),
              GroupColorPicker(),
              GroupFriendsSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
