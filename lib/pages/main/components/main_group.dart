import 'package:dotted_border/dotted_border.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_streamer.dart';
import 'package:dutch_hallae/pages/main/groups/group_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainGroupComponent extends GetView<GroupController> {
  const MainGroupComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return Obx(
      () => controller.favoriteGroupName.value == ''
          ? InkWell(
              onTap: () => Get.to(() => const GroupPage()),
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.grey,
                radius: const Radius.circular(12),
                child: SizedBox(
                  width: Get.width,
                  height: Get.width * 0.5,
                  child: const Center(child: Text('즐겨찾는 모임이 없어요')),
                ),
              ),
            )
          : InkWell(
              onTap: () => Get.to(() => const GroupPage()),
              child: GroupBubble(
                name: controller.favoriteGroupName.value,
                image: controller.favoriteGroupImage.value,
                colorValue: Colors.black.value,
                members: controller.favoriteGroupMembers,
                isFavorite: true,
              ),
            ),
    );
  }
}
