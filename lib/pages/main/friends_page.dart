import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  //TODO: contacts_service package로 폰 주소록에 있는 목록 불러오기
  //TODO: cloud firestore에 저장하지 않고,
  //TODO: 나중에 모임목록에 추가된 친구만 firestore에 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구목록'),
      ),
    );
  }
}
