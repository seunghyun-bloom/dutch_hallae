import 'package:dutch_hallae/utilities/add_friend.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구목록'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Pantone.veryPeri,
        child: const Icon(Icons.add),
        onPressed: () => AddFriendPopup(context),
      ),
    );
  }
}
