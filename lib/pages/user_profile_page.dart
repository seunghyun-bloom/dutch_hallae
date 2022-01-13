import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/utilities/selection_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String defaultProfile =
      'https://i.ibb.co/Hx9LP5Z/default-profile-image.png';
  final String ireneImage =
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202112/16/4ab8f74f-79e5-4c14-bdbe-efe62f05b6ee.jpg';

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
                  Text("이것은 성진이 만든 것"),
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
                  SelectionCard(label: '계좌정보 보러가기', onTap: () {}),
                  SelectionCard(label: '정산기록 보러가기', onTap: () {}),
                  SelectionCard(label: '설정하러 가기', onTap: () {}),
                ],
              ),
            ),
            bottomNavigationBar: InkWell(
              child: Container(
                height: 70,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'sign out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              onTap: () {
                _auth.signOut();
              },
            ),
          );
        }
      },
    );
  }
}
