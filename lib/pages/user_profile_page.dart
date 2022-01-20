import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String defaultProfile =
      'https://i.ibb.co/Hx9LP5Z/default-profile-image.png';

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
                      snapshot.data?.photoURL == null
                          ? defaultProfile
                          : '${snapshot.data?.photoURL}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      snapshot.data?.displayName == null
                          ? 'Guest'
                          : '${snapshot.data?.displayName}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('프로필 수정'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    onPressed: () => showToast('프로필을 수정해보세요!'),
                  ),
                  TextButton(
                    child: const Text('설정 하기'),
                    onPressed: () => showToast('무엇을 설정할까?'),
                  ),
                  const SizedBox(height: 150),
                  OutlinedButton(
                    child: const Text('로그아웃'),
                    style: kRedOutlinedButtonStyle,
                    onPressed: () => _auth.signOut(),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    child: const Text('회원탈퇴'),
                    style: kRedOutlinedButtonStyle,
                    onPressed: () => _auth.currentUser?.delete(),
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
