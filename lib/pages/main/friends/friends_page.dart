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
      // bottomSheet: Padding(
      //   padding: EdgeInsets.all(20.h),
      //   child: Obx(
      //     () => _getxFriend.showCreateGroupButton.value
      //         ? SizedBox(
      //             height:
      //                 (Get.height - AppBar().preferredSize.height) * 0.9 * 0.1,
      //             child: Padding(
      //               padding: EdgeInsets.symmetric(
      //                   horizontal: 10,
      //                   vertical: (Get.height - AppBar().preferredSize.height) *
      //                       0.95 *
      //                       0.1 *
      //                       0.1),
      //               child: StretchedButton(
      //                 color: Palette.basicBlue,
      //                 title: '모임 만들기',
      //                 onTap: () {
      //                   Get.back();
      //                   Get.to(() => GroupAddPage());
      //                 },
      //               ),
      //             ),
      //           )
      //         : const SizedBox(),
      //   ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //TODO: iOS & Galaxy 사이즈 맞추기
          Expanded(
            child: SizedBox(
              // height: Get.mediaQuery.size.height -
              //     Get.mediaQuery.padding.top -
              //     Get.mediaQuery.padding.bottom -
              //     AppBar().preferredSize.height -
              //     90.h,
              child: const SingleChildScrollView(
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
