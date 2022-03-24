import 'dart:io';

import 'package:dutch_hallae/getx/controller/image_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModalFit extends StatefulWidget {
  ModalFit({Key? key, required this.friend, required this.number})
      : super(key: key);
  String friend;
  String number;

  @override
  State<ModalFit> createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  @override
  Widget build(BuildContext context) {
    final _getxImage = Get.put(ImageController());
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: InkWell(
                child: CircleAvatar(
                  backgroundImage:
                      FileImage(File(_getxImage.friendImageTemp.value)),
                  radius: 50,
                ),
                onTap: () {
                  DialogByPlatform(
                    title: '친구 사진',
                    content: '어디에서 불러오시겠습니까?',
                    leftLabel: '사진첩',
                    onTap: () => _getxImage.getFriendImage(ImageSource.gallery),
                    rightLabel: '카메라',
                    onRightTap: () =>
                        _getxImage.getFriendImage(ImageSource.camera),
                    context: context,
                  );
                },
              ),
            ),
            Text(
              '${widget.friend} 님의\n프로필을 완성해 보세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
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
                        print(_getxImage.friendImageTemp);
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
}
