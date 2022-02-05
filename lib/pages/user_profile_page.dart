import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/firebase/firestore/user_data_controller.dart';
import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/pages/profile_modify_page.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String defaultProfile = 'https://i.ibb.co/Hx9LP5Z/default-profile-image.png';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _userData = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Get.put(UserDataController());
    return StreamBuilder(
      stream: _auth.userChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data == null) {
          return LoginPage();
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('마이페이지')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(
                        Get.find<UserDataController>().profileImageFS.isEmpty
                            ? defaultProfile
                            : Get.find<UserDataController>()
                                .profileImageFS
                                .value,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(() => Text(
                          Get.find<UserDataController>().displayNameFS.isEmpty
                              ? ''
                              : Get.find<UserDataController>()
                                  .displayNameFS
                                  .value,
                          style: const TextStyle(fontSize: 20),
                        )),
                  ),
                  ElevatedButton(
                    child: const Text('프로필 수정'),
                    style: kRoundedButtonStyle,
                    onPressed: () => Get.to(() => const ProfileModifyPage()),
                  ),
                  TextButton(
                    child: const Text('설정 하기'),
                    onPressed: () => showToast('무엇을 설정할까?'),
                  ),
                  const SizedBox(height: 100),
                  OutlinedButton(
                    child: const Text('로그아웃'),
                    style: kRedOutlinedButtonStyle,
                    onPressed: () {
                      _auth.signOut();
                      Get.back();
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    child: const Text('회원탈퇴'),
                    style: kRedOutlinedButtonStyle,
                    onPressed: () {
                      DialogByPlatform(
                          title: '회원탈퇴',
                          content: '정말로 탈퇴하시겠습니까?',
                          onTap: () {
                            _auth.currentUser?.delete();
                            _firestore
                                .collection('userData')
                                .doc(_userData?.uid)
                                .delete();
                            _firebaseStorage
                                .ref()
                                .child('profile/${_userData?.uid}')
                                .delete();
                            Get.back();
                          },
                          context: context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
