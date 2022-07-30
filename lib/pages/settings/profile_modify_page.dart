import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/getx/controller/image_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModifyPage extends StatefulWidget {
  const ProfileModifyPage({Key? key}) : super(key: key);

  @override
  _ProfileModifyPageState createState() => _ProfileModifyPageState();
}

class _ProfileModifyPageState extends State<ProfileModifyPage> {
  final _getxUser = Get.put(UserDataController());
  final _getxImage = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필 수정')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Obx(
                () => CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(_getxUser.profileImageFS.value),
                  foregroundColor: Colors.white,
                  child: const FaIcon(FontAwesomeIcons.solidEdit),
                ),
              ),
              onTap: () {
                DialogByPlatform(
                  title: '프로필 사진 변경',
                  content: '어디에서 불러오시겠습니까?',
                  rightLabel: '사진첩',
                  onTap: () =>
                      _getxImage.uploadProfileImage(ImageSource.gallery),
                  leftLabel: '카메라',
                  onLeftTap: () =>
                      _getxImage.uploadProfileImage(ImageSource.camera),
                  context: context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
