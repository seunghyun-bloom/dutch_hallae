import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/friends/friend_add_page.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_friend_add.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';

class AddAtFriendsList {
  BuildContext context;
  AddAtFriendsList({required this.context}) {
    showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.scale,
        duration: const Duration(milliseconds: 300),
        builder: (BuildContext context) {
          return SelectMemberDialogContents();
        });
  }
}

class SelectMemberDialogContents extends StatelessWidget {
  SelectMemberDialogContents({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: SizedBox(
          width: Get.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('userData')
                .doc('${_auth.currentUser?.uid}')
                .collection('friends')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data?.docs.length == 0) {
                return NoDataSquare(
                  titleString: '친구를 추가해 주세요',
                  contentString: '아직 등록된 친구가 없으시네요\n친구를 추가해 보세요',
                  onTap: () => Get.to(() => const FriendAddPage()),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return FriendsBubble(
                      name: snapshot.data?.docs[index]['name'],
                      image: snapshot.data?.docs[index]['image'],
                      phone: snapshot.data?.docs[index]['phone'],
                      index: index,
                    );
                  },
                );
              }
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              FriendAddOnce(context: context);
            },
            child: const Text('새로 추가'),
          ),
        ],
      ),
    );
  }
}

class FriendsBubble extends GetView<RecordController> {
  final String name;
  final String image;
  final String phone;
  final int index;

  FriendsBubble(
      {Key? key,
      required this.name,
      required this.image,
      required this.phone,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedMembersInfo.add(
          {'name': name, 'image': image},
        );
        Get.back();
        Get.back();
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
          backgroundColor: Colors.grey.shade300,
        ),
        title: Text(
          name,
        ),
        subtitle: Text(
          phone,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
