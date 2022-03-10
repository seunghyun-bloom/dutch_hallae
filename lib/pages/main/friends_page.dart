import 'package:dutch_hallae/pages/main/add_friends_page.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구목록'),
        actions: [
          AppBarButton(
            title: '추가',
            onTap: () {
              Get.to(() => const AddFriendsPage());
            },
          ),
        ],
      ),
      body: NoData(
        subject: '친구가',
        object: '친구를',
        onTap: () {
          Get.to(() => const AddFriendsPage());
        },
      ),
    );
  }
}
