import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/pages/user_profile_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.userChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data == null) {
          return LoginPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const FaIcon(
                FontAwesomeIcons.moneyBillWave,
                color: Colors.green,
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${snapshot.data?.photoURL}'),
                    ),
                    accountName: Text('${snapshot.data?.displayName}'),
                    accountEmail: Text('${snapshot.data?.email}'),
                    decoration: kDrawerHeaderStyle,
                    onDetailsPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.userAlt),
                    title: const Text('마이페이지'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.users),
                    title: const Text('모임관리'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.userFriends),
                    title: const Text('친구목록'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.moneyCheckAlt),
                    title: const Text('계좌관리'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.clipboardList),
                    title: const Text('정산기록'),
                    onTap: () {},
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                    height: 20,
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.info),
                    title: const Text('앱 정보'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.userShield),
                    title: const Text('개인정보 처리방침'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.starHalfAlt),
                    title: const Text('앱 평가하기'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.indigo.shade100,
                        clipBehavior: Clip.antiAlias,
                        shape: kShape20,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('계좌정보'),
                              trailing: ElevatedButton(
                                child: const Text('변경'),
                                style: kRoundedButtonStyle,
                                onPressed: () {},
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Divider(color: Colors.blueGrey),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('국민은행'),
                                subtitle: Text('123-4567-54321'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('지난 정산 내역'),
                          TextButton(
                            child: const Text('더보기 >'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                            color: Colors.blueGrey.shade100,
                            shape: kShape20,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        FaIcon(FontAwesomeIcons.userAlt),
                                        SizedBox(width: 10),
                                        Text(
                                          '4',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text('2022.01.12'),
                                  const Text(
                                    '아미들 모임',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    '130,000 원',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('모임 목록'),
                          TextButton(
                            child: const Text('더보기 >'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                            color: Colors.pink.shade100,
                            shape: kShape20,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        FaIcon(FontAwesomeIcons.userAlt),
                                        SizedBox(width: 10),
                                        Text(
                                          '4',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    '아미들 모임',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            child: const Text(
                              '정산하러 가기',
                              style: TextStyle(fontSize: 18),
                            ),
                            style: kRoundedButtonStyle,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
