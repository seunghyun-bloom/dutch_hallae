import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/friends/friend_add_page.dart';
import 'package:dutch_hallae/pages/main/friends/modal_fit.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_friend_add.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_friend_add_list.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/mini_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//TODO: 모임에 속하지 않은 일회성 멤버 추가 기능

class SelectMemberPopup {
  BuildContext context;
  String groupName;
  SelectMemberPopup({required this.context, required this.groupName}) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.scale,
      duration: const Duration(milliseconds: 300),
      builder: (BuildContext context) {
        return SelectMemberPopupContents(groupName: groupName);
      },
    );
  }
}

class SelectMemberPopupContents extends GetView<RecordController> {
  final String groupName;
  SelectMemberPopupContents({Key? key, required this.groupName})
      : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    return SafeArea(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: SizedBox(
          width: Get.width,
          child: StreamBuilder<DocumentSnapshot>(
            stream: _firestore
                .collection('userData')
                .doc('${_auth.currentUser?.uid}')
                .collection('groups')
                .doc(groupName)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              for (int i = 0; i < snapshot.data!['members'].length; i++) {
                controller.isSelectedMember.add(false);
              }
              // List<dynamic> friends = snapshot.data!['members'];
              // for (var friend in friends) {
              //   controller.isSelectedMember.add(false);
              // }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!['members'].length,
                itemBuilder: (context, index) {
                  return FriendBubble(
                    image: snapshot.data!['members'][index]['image'],
                    name: snapshot.data!['members'][index]['name'],
                    index: index,
                  );
                },
              );
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.back();
              await Future.delayed(const Duration(milliseconds: 500));
              controller.resetPickedGroup();
              controller.resetSelectedMembers();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text('목록에 없는 멤버'),
            onPressed: () {
              AddAtFriendsList(context: context);
            },
          ),
          ElevatedButton(
            child: const Text('추가'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}

class FriendBubble extends GetView<RecordController> {
  String image;
  String name;
  int index;
  FriendBubble({
    Key? key,
    required this.image,
    required this.name,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
        backgroundColor: Colors.white,
      ),
      title: Text(name),
      trailing: Obx(
        () => Checkbox(
          value: controller.isSelectedMember[index],
          onChanged: (value) {
            controller.isSelectedMember[index] = value;
            if (value!) {
              controller.selectedMembersInfo
                  .add({'name': name, 'image': image});
            } else {
              int i = 0;
              for (var selectedMember in controller.selectedMembersInfo) {
                if (selectedMember['name'] == name) {
                  controller.selectedMembersInfo.removeAt(i);
                }
                i++;
              }
            }
          },
        ),
      ),
    );
  }
}

class ShowingSelectedMembers extends GetView<RecordController> {
  const ShowingSelectedMembers({Key? key}) : super(key: key);

  final String questionMark =
      'https://media.istockphoto.com/photos/question-mark-3d-red-interrogation-point-asking-sign-punctuation-mark-picture-id1023347350?k=20&m=1023347350&s=612x612&w=0&h=VogcQy0SJJYgV_TItvoIRowOCR93tuCmO9o3AY-_mCg=';

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    return Obx(
      () {
        if (controller.selectedMembersInfo.isEmpty) {
          return SizedBox(
            height: 50.h,
            child: const Center(child: Text('구성원을 추가해주세요')),
          );
        }

        List<MiniProfile> miniProfileList = <MiniProfile>[];
        int i = 0;
        for (var selectedMember in controller.selectedMembersInfo) {
          miniProfileList.add(
            MiniProfile(
              image: NetworkImage(
                  controller.selectedMembersInfo[i]['image'] ?? questionMark),
              name: controller.selectedMembersInfo[i]['name'] ?? '?',
            ),
          );
          i++;
        }

        return Wrap(
          children: miniProfileList,
        );
      },
    );
  }
}
