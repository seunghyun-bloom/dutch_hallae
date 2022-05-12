import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/pages/main/friends/add_friends_page.dart';
import 'package:dutch_hallae/pages/main/friends/friends_streamer.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

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
              Get.to(() => const AddFriendsPage());
            },
          ),
        ],
      ),
      body: const FriendsStreamer(),
    );
  }
}
