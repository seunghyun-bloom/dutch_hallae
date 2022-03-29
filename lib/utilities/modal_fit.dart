import 'dart:io';

import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModalFit extends StatelessWidget {
  ModalFit({Key? key, required this.friend, required this.phone})
      : super(key: key);
  final String friend;
  final String phone;

  final _getxFriends = Get.put(FriendsController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: InkWell(
                child: Obx(() => _getxFriends.isSample.value
                    ? _circleAvatar(
                        AssetImage(_getxFriends.showingFriendImage.value))
                    : _circleAvatar(FileImage(
                        File(_getxFriends.showingFriendImage.value)))),
                onTap: () {
                  DialogByPlatform(
                    title: '친구 사진',
                    content: '어디에서 불러오시겠습니까?',
                    leftLabel: '사진첩',
                    onTap: () =>
                        _getxFriends.getFriendImage(ImageSource.gallery),
                    rightLabel: '카메라',
                    onRightTap: () =>
                        _getxFriends.getFriendImage(ImageSource.camera),
                    context: context,
                  );
                },
              ),
            ),
            Text(
              '$friend 님의\n프로필을 완성해 보세요',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            SizedBox(height: 10.h),
            sampleImages(0),
            sampleImages(5),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 45,
                    child: ElevatedButton(
                      child: const Text(
                        '지우기',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 45,
                    child: ElevatedButton(
                      child: const Text(
                        '완료',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        _getxFriends.uploadFriendFirestore(friend, phone);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sampleImages(int startNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = startNumber; i <= startNumber + 4; i++)
            InkWell(
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/friend_sample_$i.jpeg'),
                backgroundColor: Colors.grey.shade300,
              ),
              onTap: () => _getxFriends.selectSampleImage(i),
            ),
        ],
      ),
    );
  }

  _circleAvatar(ImageProvider imageProvider) {
    return CircleAvatar(
      backgroundImage: imageProvider,
      backgroundColor: Colors.grey.shade300,
      radius: 50,
    );
  }
}
