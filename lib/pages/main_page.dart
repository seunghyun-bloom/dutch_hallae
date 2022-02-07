import 'package:dutch_hallae/firebase/firestore/bank_account_controller.dart';
import 'package:dutch_hallae/firebase/firestore/user_data_controller.dart';
import 'package:dutch_hallae/pages/account_page.dart';
import 'package:dutch_hallae/pages/login_page.dart';
import 'package:dutch_hallae/pages/user_profile_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _getxBank = Get.put(BankAccountController());
  final _getxUser = Get.put(UserDataController());

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
              title: const Text('더치할래'),
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Obx(
                    () => UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                          _getxUser.profileImageFS.isEmpty
                              ? defaultProfile
                              : _getxUser.profileImageFS.value,
                        ),
                      ),
                      accountName: Text(
                        _getxUser.displayNameFS.isEmpty
                            ? 'Guest'
                            : _getxUser.displayNameFS.value,
                      ),
                      accountEmail: Text(
                        _getxUser.emailFS.isEmpty
                            ? ''
                            : _getxUser.emailFS.value,
                      ),
                      decoration: kDrawerHeaderStyle,
                      onDetailsPressed: () => Get.to(() => UserProfilePage()),
                    ),
                  ),
                  ListTile(
                      leading: const FaIcon(FontAwesomeIcons.userAlt),
                      title: const Text('마이페이지'),
                      onTap: () {
                        Get.back();
                        Get.to(() => UserProfilePage());
                      }),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.users),
                    title: const Text('모임관리'),
                    onTap: () {},
                  ),
                  //TODO: 친구목록을 만들어보자
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.userFriends),
                    title: const Text('친구목록'),
                    onTap: () {},
                  ),
                  ListTile(
                      leading: const FaIcon(FontAwesomeIcons.moneyCheckAlt),
                      title: const Text('계좌관리'),
                      onTap: () {
                        Get.back();
                        Get.to(() => AccountPage());
                      }),
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
                  padding: EdgeInsets.all(15.w),
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
                                onPressed: () => Get.to(() => AccountPage()),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Divider(color: Colors.blueGrey),
                            ),
                            InkWell(
                              onTap: () => Get.to(() => AccountPage()),
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            _getxBank.accountNameFS.value,
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '  (예금주: ${_getxBank.accountHolderFS.value})',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              _getxBank.bankFS.value,
                                              style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 17.sp,
                                              ),
                                            ),
                                            Text(
                                              _getxBank.accountNumberFS.isEmpty
                                                  ? '즐겨찾는 계좌를 설정해주세요'
                                                  : '  ${_getxBank.accountNumberFS.value}',
                                              style: TextStyle(
                                                fontSize: _getxBank
                                                        .accountNumberFS.isEmpty
                                                    ? 14.sp
                                                    : 17.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                          physics: const ClampingScrollPhysics(),
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
                                      children: [
                                        FaIcon(FontAwesomeIcons.userAlt),
                                        SizedBox(width: 10.w),
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
                          physics: const ClampingScrollPhysics(),
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
                            onPressed: () {
                              print(
                                  'displayName : ${Get.find<UserDataController>().displayNameFS.value}');
                              print(
                                  'profileImage : ${Get.find<UserDataController>().profileImageFS.value}');
                              print(
                                  'uid : ${Get.find<UserDataController>().uidFS.value}');
                              print(
                                  'accountName : ${Get.find<BankAccountController>().accountNameFS}');
                              print(
                                  'bank : ${Get.find<BankAccountController>().bankFS}');
                              print(
                                  'number : ${Get.find<BankAccountController>().accountNumberFS}');
                            },
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
