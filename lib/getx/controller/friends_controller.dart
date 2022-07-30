import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

String _defaultImageURL =
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_0.png?alt=media&token=bbb403a6-3ef9-495d-a7eb-2b60c0b3562c';
String defaultImage = 'assets/images/profile_sample_0.png';

class FriendsController extends GetxController {
  RxString friendImageURL = _defaultImageURL.obs;
  RxString showingFriendImage = defaultImage.obs;
  List<String> sampleFriendImages = [
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_0.png?alt=media&token=bbb403a6-3ef9-495d-a7eb-2b60c0b3562c',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_1.png?alt=media&token=db87e4a1-4c84-4756-aa1b-87a998be8e4e',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_2.png?alt=media&token=f323c5a1-19a3-49de-b472-b8e5ec01f090',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_3.png?alt=media&token=fa32e2d8-bc9f-41f8-882a-380d39f03dfa',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_4.png?alt=media&token=b4686a50-e483-41c4-a853-d3e975a3377f',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_5.png?alt=media&token=0649ff05-c446-48e8-8812-f976f2ea9211',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_6.png?alt=media&token=99c4eb87-f88a-45a0-b64a-521169288bc1',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_7.png?alt=media&token=00b8d856-3736-41a3-8782-95077946b97c',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_8.png?alt=media&token=658c0162-0438-43a4-a9bd-370ba08b220c',
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Fprofile_sample_9.png?alt=media&token=8a37ab07-be15-48e2-8a45-2b280d469916',
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
    );

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      maxHeight: 300,
      maxWidth: 300,
      sourcePath: ximage!.path,
      aspectRatio: const CropAspectRatio(ratioX: 300, ratioY: 300),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '사진 업로드',
          toolbarColor: Colors.black87,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(
          title: '사진 업로드',
          doneButtonTitle: '업로드',
          cancelButtonTitle: '취소',
        ),
      ],
    );

    showingFriendImage(croppedFile?.path);
  }

  changeFriendImage(ImageSource source) async {
    imageChanged(true);

    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 1260,
      maxWidth: 1260,
    );

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: ximage!.path,
      aspectRatio: const CropAspectRatio(ratioX: 300, ratioY: 300),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '사진 업로드',
          toolbarColor: Colors.black87,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(title: '사진 업로드'),
      ],
    );

    changedImage(croppedFile?.path);

    Get.back();
  }

  openFriendInfo() {
    imageChanged(false);
  }

  selectSampleImage(int i) {
    isSample(true);
    String selectedSampleImage = sampleFriendImages[i];
    friendImageURL(selectedSampleImage);
    showingFriendImage('assets/images/profile_sample_$i.png');
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
          rightLabel: '삭제 후 추가',
          leftLabel: '돌아가기',
          onTap: () async {
            await storageUploader(
                isSample.value, uploadName, showingFriendImage.value);
            firestoreUploader(uploadName, phone, friendImageURL.value);
            Get.back();
          },
          onLeftTap: () => Get.back(),
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
