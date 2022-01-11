import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/utilities/selection_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final String ireneImage =
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202112/16/4ab8f74f-79e5-4c14-bdbe-efe62f05b6ee.jpg';

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
    //     if (snapshot.data == null) {
    //       return const LoginPage();
    //     } else {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(ireneImage),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '아이린',
                style: TextStyle(fontSize: 20),
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
              '프로필 수정',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
    );
    //     }
    //   },
    // );
  }
}
