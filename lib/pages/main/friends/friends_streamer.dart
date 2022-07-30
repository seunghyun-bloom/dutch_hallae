import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/friends/friend_add_page.dart';
import 'package:dutch_hallae/pages/main/friends/friend_info.dart';
import 'package:dutch_hallae/pages/main/groups/group_add_page.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final _getxfriends = Get.put(FriendsController());
final _getxGroup = Get.put(GroupController());

class FriendsStreamer extends StatefulWidget {
  const FriendsStreamer({Key? key}) : super(key: key);

  @override
  State<FriendsStreamer> createState() => _FriendsStreamerState();
}

class _FriendsStreamerState extends State<FriendsStreamer> {
  @override
  void initState() {
    _getxGroup.resetSelectedMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('userData')
          .doc('${_auth.currentUser?.uid}')
          .collection('friends')
          .orderBy('timeStamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // _getxGroup.isSelected.clear();
        // _getxGroup.selectedMembersInfo.clear();

        final friends = snapshot.data?.docs.reversed;
        for (var friend in friends!) {
          _getxGroup.isSelected.add(false);
        }

        if (snapshot.data?.docs.length == 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _getxfriends.showCreateGroupButton(false);
          });
          return NoDataSquare(
            titleString: '친구를 추가해 주세요',
            contentString: '아직 등록된 친구가 없으시네요\n친구를 추가해 보세요',
            onTap: () => Get.to(() => const FriendAddPage()),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _getxfriends.showCreateGroupButton(true);
          });
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return FriendsBubble(
                    name: snapshot.data?.docs[index]['name'],
                    image: snapshot.data?.docs[index]['image'],
                    phone: snapshot.data?.docs[index]['phone'],
                    groups: snapshot.data?.docs[index]['groups'],
                    index: index,
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

class FriendsBubble extends StatelessWidget {
  final String name;
  final String image;
  final String phone;
  final int index;
  List? groups;

  FriendsBubble({
    Key? key,
    required this.name,
    required this.image,
    required this.phone,
    required this.index,
    this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _getxfriends.openFriendInfo();
        FriendInfo(context: context, name: name, phone: phone, image: image);
      },
      child: ListTile(
        style: ListTileStyle.list,
        contentPadding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 14.w),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
          backgroundColor: Colors.grey.shade300,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
            ),
            groups!.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      Text(
                        groups!.last,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        groups!.length > 1 ? ' 외 ${groups!.length - 1}개' : '',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
        subtitle: Text(
          phone,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Obx(
          () => Checkbox(
            value: _getxGroup.isSelected[index],
            onChanged: (value) {
              _getxGroup.isSelected[index] = value;
              if (value!) {
                _getxGroup.selectedMembersInfo
                    .add({'name': name, 'image': image});
              } else {
                int i = 0;
                for (var selectedMember in _getxGroup.selectedMembersInfo) {
                  if (_getxGroup.selectedMembersInfo[i]['name'] == name) {
                    _getxGroup.selectedMembersInfo.removeAt(i);
                  }
                  i++;
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
