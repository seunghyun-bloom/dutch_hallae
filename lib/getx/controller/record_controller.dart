import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RecordController extends GetxController {
  late Stream<QuerySnapshot> firestoreQuery;
  RxString title = ''.obs;
  RxInt totalAmount = 0.obs;
  RxList<bool?> isSelectedMember = [false].obs;
  RxList<Map<String, String>> selectedMembersInfo = <Map<String, String>>[].obs;
  DateTime meetingDateTime = DateTime(2000, 01, 01);
  RxString group = ''.obs;
  RxString pickedImage = ''.obs;
  Map<String, dynamic> place = <String, dynamic>{};

  getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 1260,
      maxWidth: 1260,
    );

    if (ximage == null) {
      return;
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: ximage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1260, ratioY: 1260),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '사진 업로드',
          toolbarColor: Colors.black87,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(title: '사진 업로드'),
      ],
    );

    pickedImage(croppedFile?.path);

    Get.back();
  }

  resetPickedGroup() async {
    var querySnapshot = await _firestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .collection('groups')
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({'picked': false});
    }
  }

  resetSelectedMembers() {
    isSelectedMember.clear();
    selectedMembersInfo.clear();
  }

  @override
  void onClose() {
    resetPickedGroup();
    super.onClose();
  }
}
