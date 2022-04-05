import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/pages/main/friends/add_friends_page.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class FriendsStreamer extends StatelessWidget {
  const FriendsStreamer({Key? key}) : super(key: key);

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
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
      title: Text(name),
      subtitle: Text(phone),
    );
  }
}
