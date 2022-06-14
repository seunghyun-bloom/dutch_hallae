import 'package:dutch_hallae/pages/main/groups/contents/group_color_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_image_picker.dart';
import 'package:dutch_hallae/pages/main/groups/contents/group_name_writer.dart';
import 'package:flutter/material.dart';

//TODO: 친구 고르기 - Dialog 형태

class GroupAddPage extends StatelessWidget {
  GroupAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('모임 추가')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GroupImagePicker(),
            GroupNameWriter(),
            GroupColorPicker(),
          ],
        ),
      ),
    );
  }
}
