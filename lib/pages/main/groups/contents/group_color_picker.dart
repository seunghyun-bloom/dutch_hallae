import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/contents/insert_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class GroupColorPicker extends GetView<GroupController> {
  const GroupColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return InsertGroupInfoFrame(
      title: '고유 색  지정',
      content: Center(
        child: Obx(
          () => IconButton(
            icon: const Icon(Icons.palette),
            color: controller.pickedColor.value,
            onPressed: () {
              showAnimatedDialog(
                barrierDismissible: true,
                context: context,
                animationType: DialogTransitionType.scale,
                duration: const Duration(milliseconds: 300),
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: controller.pickedColor.value,
                        onColorChanged: (Color color) {
                          controller.getGroupColor(color);
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('완료'),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
