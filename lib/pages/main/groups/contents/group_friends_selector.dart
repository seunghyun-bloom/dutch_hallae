import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/friends/friend_add_page.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_color_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/insert_frame.dart';
import 'package:dutch_hallae/utilities/mini_profile.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupFriendsSelector extends GetView<GroupController> {
  const GroupFriendsSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InsertGroupInfoFrame(
      title: '구성원 추가',
      content: InkWell(
        onTap: () => SelectMemberDialog(context: context),
        child: ShowingSelectedMembers(),
      ),
    );
  }
}

class SelectMemberDialog {
  BuildContext context;
  SelectMemberDialog({required this.context}) {
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

class SelectMemberDialogContents extends GetView<GroupController> {
  SelectMemberDialogContents({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return AlertDialog(
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

            final friends = snapshot.data?.docs.reversed;
            for (var friend in friends!) {
              controller.isSelected.add(false);
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
          onPressed: () => Get.back(),
          child: const Text('추가'),
        ),
      ],
    );
  }
}

class FriendsBubble extends GetView<GroupController> {
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
    Get.put(GroupController());
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 14.w),
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
      trailing: Obx(
        () => Checkbox(
          value: controller.isSelected[index],
          onChanged: (value) {
            controller.isSelected[index] = value;
            if (value!) {
              controller.selectedMembersInfo
                  .add({'name': name, 'image': image});
            } else {
              int i = 0;
              for (var selectedMember in controller.selectedMembersInfo) {
                if (controller.selectedMembersInfo[i]['name'] == name) {
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

class ShowingSelectedMembers extends GetView<GroupController> {
  const ShowingSelectedMembers({Key? key}) : super(key: key);

  final String questionMark =
      'https://media.istockphoto.com/photos/question-mark-3d-red-interrogation-point-asking-sign-punctuation-mark-picture-id1023347350?k=20&m=1023347350&s=612x612&w=0&h=VogcQy0SJJYgV_TItvoIRowOCR93tuCmO9o3AY-_mCg=';

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
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
