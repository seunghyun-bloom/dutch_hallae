import 'dart:io';
import 'package:dutch_hallae/firebase/firestore/create_firestore_data.dart';
import 'package:dutch_hallae/firebase/firestore/image_uploader.dart';
import 'package:dutch_hallae/pages/user_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModifyPage extends StatefulWidget {
  const ProfileModifyPage({Key? key}) : super(key: key);

  @override
  _ProfileModifyPageState createState() => _ProfileModifyPageState();
}

class _ProfileModifyPageState extends State<ProfileModifyPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('프로필 수정')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(
                    profileImageFS == null ? defaultProfile : '$profileImageFS',
                  ),
                  foregroundColor: Colors.white,
                  child: const FaIcon(FontAwesomeIcons.solidEdit),
                ),
                onTap: () {
                  Platform.isIOS
                      ? showCupertinoDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: const Text('프로필 사진 변경'),
                            content: const Text('어디에서 불러오시겠습니까?'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('사진첩'),
                                onPressed: () =>
                                    uploadImageToStorage(ImageSource.gallery),
                              ),
                              CupertinoDialogAction(
                                child: const Text('카메라'),
                                onPressed: () =>
                                    uploadImageToStorage(ImageSource.camera),
                              ),
                            ],
                          ),
                        )
                      : showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('프로필 사진 변경'),
                            content: const Text('어디에서 불러오시겠습니까?'),
                            actions: [
                              TextButton(
                                child: const Text('갤러리'),
                                onPressed: () =>
                                    uploadImageToStorage(ImageSource.gallery),
                              ),
                              TextButton(
                                child: const Text('카메라'),
                                onPressed: () =>
                                    uploadImageToStorage(ImageSource.camera),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
