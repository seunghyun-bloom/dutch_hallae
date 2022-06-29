import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

String _defaultImageURL =
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_0.jpeg?alt=media&token=3f159e77-cade-4345-8b6e-7a5d4c7e75e8';
String defaultImage = 'assets/images/friend_sample_0.jpeg';

class FriendsController extends GetxController {
  RxString friendImageURL = _defaultImageURL.obs;
  RxString showingFriendImage = defaultImage.obs;
  List<String> sampleFriendImages = [
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_0.jpeg?alt=media&token=3f159e77-cade-4345-8b6e-7a5d4c7e75e8',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_1.jpeg?alt=media&token=3e418c93-3688-4256-ba80-f9b8d05488c5',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_2.jpeg?alt=media&token=fdc0f4e5-56a6-4fe3-ad63-6f4993f479dd',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_3.jpeg?alt=media&token=e2c8c602-4460-4d8a-8fc8-597002a47225',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_4.jpeg?alt=media&token=1ed26537-7130-4a42-806b-c6f03df99e69',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_5.jpeg?alt=media&token=5b3fad8b-ca4d-4fb7-a55f-bf92aad09fbc',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_6.jpeg?alt=media&token=43b34226-23d2-431f-b3c2-1cd4eafad4a2',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_7.jpeg?alt=media&token=cdf99d99-1d53-4148-b99c-9579778bfc49',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_8.jpeg?alt=media&token=970360fd-32fc-4677-b55e-3f33c732e1cf',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_9.jpeg?alt=media&token=ffd0c33a-dc81-412a-b090-61dbd6630f6e'
  ];
  final CollectionReference _firestoreREF = _firestore
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('friends');
  final Reference _storageREF = _firebaseStorage
      .ref()
      .child('user')
      .child('${_auth.currentUser?.uid}')
      .child('friends');

  String downloadUrlTemp = '';
  RxBool isSample = true.obs;
  RxBool imageChanged = false.obs;
  RxString changedImage = ''.obs;
  RxBool showCreateGroupButton = true.obs;

  getFriendImage(ImageSource source) async {
    isSample(false);
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 300,
      maxWidth: 300,
    );

    showingFriendImage(ximage!.path);

    Get.back();
  }

  changeFriendImage(ImageSource source) async {
    imageChanged(true);

    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 300,
      maxWidth: 300,
    );

    changedImage(ximage!.path);

    Get.back();
  }

  openFriendInfo() {
    imageChanged(false);
  }

  selectSampleImage(int i) {
    isSample(true);
    String selectedSampleImage = sampleFriendImages[i];
    friendImageURL(selectedSampleImage);
    showingFriendImage('assets/images/friend_sample_$i.jpeg');
  }

  uploadFriendFirebase(String name, String phone, String textfieldValue,
      BuildContext context) async {
    String uploadName = name;

    if (textfieldValue != '') {
      uploadName = textfieldValue;
    }

    await _firestoreREF.doc(uploadName).get().then((value) async {
      if (value.exists == true) {
        DialogByPlatform(
          title: '이미 등록된 친구',
          content: '기존 정보를 삭제하고 새로 추가하시겠습니까?\n동명이인이라면 다른 이름을 지정해주세요.',
          leftLabel: '삭제 후 추가',
          rightLabel: '돌아가기',
          onTap: () async {
            await storageUploader(
                isSample.value, uploadName, showingFriendImage.value);
            firestoreUploader(uploadName, phone, friendImageURL.value);
            Get.back();
          },
          onRightTap: () => Get.back(),
          context: context,
        );
      } else {
        Loading(context);
        await storageUploader(
            isSample.value, uploadName, showingFriendImage.value);
        await firestoreUploader(uploadName, phone, friendImageURL.value);
      }
    });
  }

  changeFriendFirestore(String name, String phone, String textfieldValue,
      BuildContext context) async {
    Loading(context);
    String newPhone = phone;
    if (textfieldValue != '') {
      newPhone = textfieldValue;
    }

    if (imageChanged.isTrue) {
      await storageUploader(false, name, changedImage.value);
      firestoreUploader(name, newPhone, friendImageURL.value);
      imageChanged(false);
    } else {
      firestoreUploader(name, newPhone, 'DoNotChange');
    }
    Get.back();
  }

  firestoreUploader(String name, String phone, String imageURL) {
    if (imageURL == 'DoNotChange') {
      _firestoreREF.doc(name).update({
        'name': name,
        'phone': phone,
        'groups': [],
        'timeStamp': Timestamp.now(),
      });
    } else {
      _firestoreREF.doc(name).set({
        'name': name,
        'phone': phone,
        'image': imageURL,
        'groups': [],
        'timeStamp': Timestamp.now(),
      });
    }
    Get.back();
    showToast('$name님의 정보가 업데이트 되었습니다.');
    showingFriendImage(defaultImage);
    isSample(true);
  }

  storageUploader(bool isSample, String name, String imagePath) async {
    Reference refSelected = _storageREF.child('selected_profile').child(name);

    if (isSample == false) {
      File friendImage = File(imagePath);

      UploadTask uploadTask = refSelected.putFile(friendImage);

      await uploadTask.whenComplete(() => null);

      String downloadURL = await refSelected.getDownloadURL();
      friendImageURL(downloadURL);
    }
  }

  deleteFriend(String name, BuildContext context) {
    DialogByPlatform(
      title: '친구 정보 삭제',
      content: '$name님의 정보를 정말로 삭제하시겠습니까?',
      onTap: () async {
        Loading(context);
        storageEraser(name);
        await firestoreEraser(name);
        Get.back();
        Get.back();
        Get.back();
        showToast('$name님의 정보가 삭제 되었습니다.');
      },
      context: context,
    );
  }

  firestoreEraser(String name) async {
    DocumentReference reference = _firestoreREF.doc(name);
    await reference.delete();
  }

  storageEraser(String name) async {
    Reference friendRef = _storageREF.child('selected_profile').child(name);
    await friendRef.delete();
  }
}
