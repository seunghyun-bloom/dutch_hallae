import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

String _defaultImage = 'assets/images/group_sample.png';

class GroupController extends GetxController {
  Rx<Color> pickedColor = Color(0xff6667ab).obs;
  RxString pickedImage = _defaultImage.obs;
  String writedName = '';
  RxBool isSample = true.obs;
  RxBool imageChanged = false.obs;
  RxList<String> selectedMembers = [''].obs;
  RxList<bool?> isSelected = [false].obs;
  RxList<Map<String, String>> selectedMembersInfo = <Map<String, String>>[].obs;

  getGroupImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 500,
      maxWidth: 500,
    );

    pickedImage(ximage!.path);
    isSample(false);

    Get.back();
  }

  getGroupColor(Color color) {
    pickedColor(color);
  }
}
