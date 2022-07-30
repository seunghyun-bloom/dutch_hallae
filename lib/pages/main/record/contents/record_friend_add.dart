import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/friends_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/modifiable_avatar.dart';
import 'package:dutch_hallae/utilities/textfield_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController _textEditingController = TextEditingController();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class FriendAddOnce {
  BuildContext context;
  FriendAddOnce({required this.context}) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.scale,
      duration: const Duration(milliseconds: 300),
      builder: (BuildContext context) {
        return FriendAddOnceContents();
      },
    );
  }
}

class FriendAddOnceContents extends StatelessWidget {
  FriendAddOnceContents({Key? key}) : super(key: key);

  final _getxFriend = Get.put(FriendsController());
  final _getxRecord = Get.put(RecordController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => _getxFriend.getFriendImage(ImageSource.gallery),
                child: SizedBox(
                  width: Get.mediaQuery.size.width * 0.25,
                  height: Get.mediaQuery.size.width * 0.25,
                  child: _getxFriend.isSample.value
                      ? ModifiableAvatar(
                          image: const AssetImage(
                              'assets/images/friend_sample_0.jpeg'),
                        )
                      : ModifiableAvatar(
                          image: FileImage(
                            File(_getxFriend.showingFriendImage.value),
                          ),
                        ),
                ),
              ),
              TextField(
                decoration: const InputDecoration(labelText: '친구 이름'),
                controller: _textEditingController,
                maxLength: 10,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('추가'),
          onPressed: () async {
            await _getxFriend.uploadFriendFirebase(
              _textEditingController.text,
              '',
              _textEditingController.text,
              context,
            );
            var docRef = await _firestore
                .collection('userData')
                .doc('${_auth.currentUser?.uid}')
                .collection('friends')
                .doc(_textEditingController.text)
                .get()
                .then(
              (DocumentSnapshot doc) {
                return doc.data() as Map<String, dynamic>;
              },
              onError: (e) => print("Error getting document: $e"),
            );

            _getxRecord.selectedMembersInfo.add({
              'name': _textEditingController.text,
              'image': docRef['image'],
            });
            Get.back();
            Get.back();
            Get.back();
          },
        ),
      ],
    );
  }
}
