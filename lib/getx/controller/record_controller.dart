import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RecordController extends GetxController {
  late Stream<QuerySnapshot> firestoreQuery;
  RxString title = ''.obs;
  RxInt totalAmount = 0.obs;
  RxInt personalAmount = 0.obs;
  RxList<String> members = <String>[].obs;
  RxList<String> specialMembers = <String>[].obs;
  RxString group = ''.obs;
  RxString pickedImage = ''.obs;

  getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 1260,
      maxWidth: 1260,
    );

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: ximage!.path,
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
}
