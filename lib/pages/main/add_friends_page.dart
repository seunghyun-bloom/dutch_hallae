import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:flutter/material.dart';

//TODO: contacts_service package로 폰 주소록에 있는 목록 불러오기
//TODO: 처음부터 cloud firestore에 저장하지 않고,
//TODO: 선택해서 추가된 친구만 firestore에 추가

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구추가'),
        actions: [AppBarButton(title: '완료', onTap: () {})],
      ),
      body: const Center(
        child: Text('contact service package'),
      ),
    );
  }
}
