import 'dart:io';
import 'package:dutch_hallae/firebase/firestore/create_firestore_data.dart';
import 'package:dutch_hallae/pages/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _userData = FirebaseAuth.instance.currentUser;
  late File _image;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
                                    _uploadImageToStorage(ImageSource.gallery),
                              ),
                              CupertinoDialogAction(
                                child: const Text('카메라'),
                                onPressed: () =>
                                    _uploadImageToStorage(ImageSource.camera),
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
                                    _uploadImageToStorage(ImageSource.gallery),
                              ),
                              TextButton(
                                child: const Text('카메라'),
                                onPressed: () =>
                                    _uploadImageToStorage(ImageSource.camera),
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

  //TODO: Extract to seperage class
  _uploadImageToStorage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 300,
      maxWidth: 300,
    );
    File image = File(ximage!.path);

    setState(() {
      _image = image;
    });
    // Determine the path and file name of the uploading profile image
    // Remove the possibility of duplicating the file name using the user's uid.
    Reference reference =
        _firebaseStorage.ref().child('profile').child('${_userData?.uid}');

    // Upload file to Firebase storage
    UploadTask uploadTask = reference.putFile(_image);

    // wait until upload completed
    await uploadTask.whenComplete(() => null);

    // get uploaded url
    String downloadURL = await reference.getDownloadURL();

    _firebaseFirestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .update({'profileImage': downloadURL});

    Get.back();
  }
}
