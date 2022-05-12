import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/pages/main/friends/add_friends_page.dart';
import 'package:dutch_hallae/pages/main/friends/friend_info.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final _getxfriends = Get.put(FriendsController());

class FriendsStreamer extends StatefulWidget {
  const FriendsStreamer({Key? key}) : super(key: key);

  @override
  State<FriendsStreamer> createState() => _FriendsStreamerState();
}

class _FriendsStreamerState extends State<FriendsStreamer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('userData')
          .doc('${_auth.currentUser?.uid}')
          .collection('friends')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return NoDataSquare(
            subject: '친구가',
            object: '친구를',
            onTap: () {
              Get.to(() => const AddFriendsPage());
            },
          );
        }
        final friends = snapshot.data?.docs.reversed;

        List<FriendsBubble> friendsBubbles = [];

        for (var friend in friends!) {
          final friendName = friend['name'];
          final friendImage = friend['image'];
          final friendPhone = friend['phone'];

          final friendBubble = FriendsBubble(
            name: friendName,
            image: friendImage,
            phone: friendPhone,
          );

          friendsBubbles.add(friendBubble);
        }

        return ListView(
          children: friendsBubbles,
        );
      },
    );
  }
}

class FriendsBubble extends StatelessWidget {
  const FriendsBubble(
      {Key? key, required this.name, required this.image, required this.phone})
      : super(key: key);
  final String name;
  final String image;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _getxfriends.openFriendInfo();
        FriendInfo(context: context, name: name, phone: phone, image: image);
      },
      child: ListTile(
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
              style: bold20,
            ),
            const Text(
              '소속된 모임',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        subtitle: Text(
          phone,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
