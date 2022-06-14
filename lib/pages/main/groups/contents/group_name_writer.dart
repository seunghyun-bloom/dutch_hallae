import 'package:dutch_hallae/pages/main/groups/contents/insert_frame.dart';
import 'package:flutter/material.dart';

class GroupNameWriter extends StatelessWidget {
  GroupNameWriter({Key? key}) : super(key: key);

  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InsertGroupInfoFrame(
      title: '모임명',
      content: TextField(
        controller: _groupNameController,
      ),
    );
  }
}
