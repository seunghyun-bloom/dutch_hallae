import 'package:dutch_hallae/pages/main/accounts/account_page.dart';
import 'package:dutch_hallae/pages/main/friends/friends_page.dart';
import 'package:dutch_hallae/pages/main/groups/group_page.dart';
import 'package:dutch_hallae/pages/settings/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Drawer mainDrawerMenu() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(child: Image.asset('assets/images/halle_team_logo.png')),
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
  );
}
