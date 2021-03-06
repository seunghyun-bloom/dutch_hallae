import 'dart:io';

import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/modifiable_avatar.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/textfield_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utilities/dialog.dart';

class FriendInfo {
  BuildContext context;
  String name;
  String phone;
  String image;

  FriendInfo({
    required this.context,
    required this.name,
    required this.phone,
    required this.image,
  }) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.scale,
      duration: const Duration(milliseconds: 300),
      builder: (BuildContext context) {
        return FriendInfoContents(name: name, phone: phone, image: image);
      },
    );
  }
}

class FriendInfoContents extends GetView<FriendsController> {
  String name;
  String phone;
  String image;
  FriendInfoContents(
      {Key? key, required this.name, required this.phone, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    Get.put(FriendsController());
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Obx(
                () => controller.imageChanged.value
                    ? ModifiableAvatar(
                        image: FileImage(
                          File(controller.changedImage.value),
                        ),
                      )
                    : ModifiableAvatar(
                        image: NetworkImage(image),
                      ),
              ),
              onTap: () {
                DialogByPlatform(
                  title: '?????? ??????',
                  content: '???????????? ?????????????????????????',
                  rightLabel: '?????????',
                  onTap: () =>
                      controller.changeFriendImage(ImageSource.gallery),
                  leftLabel: '?????????',
                  onLeftTap: () =>
                      controller.changeFriendImage(ImageSource.camera),
                  context: context,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(name, style: bold20),
            ),
            SizedBox(
              width: 130.w,
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                maxLength: 13,
                inputFormatters: [phoneNumberFormat],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: phone,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ColoredOutlinedButton(
              title: '????????????',
              color: Palette.basicBlue,
              onTap: () => controller.changeFriendFirestore(
                  name, phone, _textEditingController.text, context),
            ),
            ColoredOutlinedButton(
              title: '????????????',
              color: Colors.red,
              onTap: () => controller.deleteFriend(name, context),
            ),
          ],
        ),
      ),
    );
  }
}
