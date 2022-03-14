import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

//TODO: contacts_service package로 폰 주소록에 있는 목록 불러오기
//TODO: 처음부터 cloud firestore에 저장하지 않고,
//TODO: 선택해서 추가된 친구만 firestore에 추가

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({Key? key}) : super(key: key);

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> {
  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    print(permissionStatus);
    if (permissionStatus != PermissionStatus.granted) {
      showToast('앱의 주소록 접근을 활성화시켜 주세요');
      Get.back();
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

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
