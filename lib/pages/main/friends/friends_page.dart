import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/pages/main/friends/friend_add_page.dart';
import 'package:dutch_hallae/pages/main/friends/friends_streamer.dart';
import 'package:dutch_hallae/pages/main/groups/group_add_page.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

final _getxFriend = Get.put(FriendsController());

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구목록'),
        actions: [
          AppBarButton(
            title: '추가',
            onTap: () {
              Get.to(() => const FriendAddPage());
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                child: FriendsStreamer(),
                physics: ScrollPhysics(),
              ),
            ),
          ),
          Obx(
            () => _getxFriend.showCreateGroupButton.value
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      child: StretchedButton(
                        height: 50,
                        color: Palette.basicBlue,
                        title: '모임 만들기',
                        onTap: () {
                          Get.back();
                          Get.to(() => GroupAddPage());
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
