import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/pages/main/accounts/account_page.dart';
import 'package:dutch_hallae/pages/main/components/main_account.dart';
import 'package:dutch_hallae/pages/main/friends/friends_page.dart';
import 'package:dutch_hallae/pages/main/groups/group_page.dart';
import 'package:dutch_hallae/pages/settings/user_profile_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/toast.dart';
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
  final _getxUser = Get.put(UserDataController());
  final _getxBank = Get.put(BankAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메인'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
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
                  _getxUser.emailFS.isEmpty ? '' : _getxUser.emailFS.value,
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
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.users),
              title: const Text('모임관리'),
              onTap: () => Get.to(() => const GroupPage()),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.userFriends),
              title: const Text('친구목록'),
              onTap: () {
                Get.back();
                Get.to(() => const FriendsPage());
              },
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
                const MainAccountComponent(),
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
                    itemBuilder: (BuildContext context, int index) => Card(
                      shape: kShape20,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    itemBuilder: (BuildContext context, int index) => Card(
                      shape: kShape20,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'main page',
        child: const Icon(Icons.add),
        onPressed: () => showToast('정산 시작'),
      ),
    );
  }
}
