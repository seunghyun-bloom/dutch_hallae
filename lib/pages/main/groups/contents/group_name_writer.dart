import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/contents/insert_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupNameWriter extends GetView<GroupController> {
  GroupNameWriter({Key? key}) : super(key: key);

  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return InsertGroupInfoFrame(
      title: '모임명',
      content: TextField(
        maxLength: 10,
        controller: _groupNameController,
        onChanged: (value) {
          controller.writedName = value;
        },
      ),
    );
  }
}
