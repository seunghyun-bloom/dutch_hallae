import 'dart:io';

import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/modifiable_avatar.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModalFit extends StatefulWidget {
  const ModalFit({Key? key, required this.friend, required this.phone})
      : super(key: key);
  final String friend;
  final String phone;

  @override
  State<ModalFit> createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  final _getxFriends = Get.put(FriendsController());

  final TextEditingController _textEditingController = TextEditingController();

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
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Obx(
                  () => _getxFriends.isSample.value
                      ? ModifiableAvatar(
                          image:
                              AssetImage(_getxFriends.showingFriendImage.value),
                        )
                      : ModifiableAvatar(
                          image: FileImage(
                            File(_getxFriends.showingFriendImage.value),
                          ),
                        ),
                ),
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
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom / 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: TextField(
                      controller: _textEditingController,
                      textAlign: TextAlign.center,
                      style: bold20,
                      decoration: InputDecoration(
                        hintText: widget.friend,
                      ),
                    ),
                  ),
                  Text(
                    '님의',
                    style: bold20,
                  ),
                ],
              ),
            ),
            Text(
              '프로필 사진을 선택해주세요',
              style: bold20,
            ),
            SizedBox(height: 10.h),
            sampleImages(0),
            sampleImages(5),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StretchedButton(
                    width: Get.width * 0.35,
                    height: 45,
                    title: '취소',
                    titleColor: Colors.black,
                    color: Colors.grey.shade300,
                    onTap: () => Get.back(),
                    showElevation: true,
                  ),
                  StretchedButton(
                    width: Get.width * 0.35,
                    height: 45,
                    title: '완료',
                    onTap: () {
                      Get.back();
                      Get.back();
                      _getxFriends.uploadFriendFirebase(widget.friend,
                          widget.phone, _textEditingController.text, context);
                    },
                    showElevation: true,
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
}
