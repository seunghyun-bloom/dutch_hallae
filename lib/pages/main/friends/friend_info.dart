import 'dart:io';

import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/utilities/styles.dart';
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

    return AlertDialog(
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
                  title: '친구 사진',
                  content: '어디에서 불러오시겠습니까?',
                  leftLabel: '사진첩',
                  onTap: () =>
                      controller.changeFriendImage(ImageSource.gallery),
                  rightLabel: '카메라',
                  onRightTap: () =>
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
              width: 120.w,
              // height: 50.h,
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: phone,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Button(
              title: '수정하기',
              color: Pantone.veryPeri,
              onTap: () => controller.changeFriendFirestore(
                  name, phone, _textEditingController.text, context),
            ),
            Button(
              title: '삭제하기',
              color: Colors.red,
              onTap: () => controller.deleteFriend(name, context),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final dynamic onTap;

  const Button({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        child: SizedBox(
          width: 180.w,
          child: Center(
            child: Text(title, style: TextStyle(color: color)),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
