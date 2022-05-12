import 'dart:io';

import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utilities/dialog.dart';

//TODO: 친구정보 편집하고 삭제하는 기능 구현  _22.05.10

final _getxFriends = Get.put(FriendsController());

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

class FriendInfoContents extends StatelessWidget {
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Obx(
              () => _getxFriends.imageChanged.value
                  ? ModifiableAvatar(
                      image: FileImage(
                        File(_getxFriends.changedImage.value),
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
                    _getxFriends.changeFriendImage(ImageSource.gallery),
                rightLabel: '카메라',
                onRightTap: () =>
                    _getxFriends.changeFriendImage(ImageSource.camera),
                context: context,
              );
            },
          ),
          Text(name),
          SizedBox(
            width: 150.w,
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: phone,
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('수정하기'),
            onPressed: () {
              _getxFriends.changeFriendFirestore(name, phone, context);
            },
          ),
          ElevatedButton(
            child: const Text('삭제하기'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
