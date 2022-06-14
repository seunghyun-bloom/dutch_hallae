import 'package:dutch_hallae/pages/main/groups/group_add_page.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 관리'),
        actions: [
          AppBarButton(
            title: '추가',
            onTap: () {
              Get.to(() => GroupAddPage());
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text('모임 정보 표기 예정'),
        ),
      ),
    );
  }
}
