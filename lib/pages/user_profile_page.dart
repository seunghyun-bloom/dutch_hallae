import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/firebase/firestore/create_firestore_data.dart';
import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/pages/profile_modify_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String defaultProfile = 'https://i.ibb.co/Hx9LP5Z/default-profile-image.png';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _userData = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage(
                      profileImageFS == null
                          ? defaultProfile
                          : '$profileImageFS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      displayNameFS == null ? 'Guest' : '$displayNameFS',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('프로필 수정'),
                    style: kRoundedButtonStyle,
                    onPressed: () => Get.to(() => ProfileModifyPage()),
                  ),
                  TextButton(
                    child: const Text('설정 하기'),
                    onPressed: () => showToast('무엇을 설정할까?'),
                  ),
                  const SizedBox(height: 150),
                  OutlinedButton(
                      onPressed: () => print(displayNameFS), child: Text('00')),
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
                      _userData?.delete();
                      Get.back();
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
