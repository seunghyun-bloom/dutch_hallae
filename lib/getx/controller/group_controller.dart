import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

String _defaultImage = 'assets/images/group_sample.png';
String _defaultImageURL =
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Fgroup%2Fgroup_sample_HQ.png?alt=media&token=b5232a4c-a891-4ac9-a9a8-995a4aa3b9a6';
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class GroupController extends GetxController {
  late Stream<QuerySnapshot> firestoreQuery;
  Rx<Color> pickedColor = const Color(0xff607d8b).obs;
  int pickedColorValue = const Color(0xff607d8b).value;
  RxString pickedImage = _defaultImage.obs;
  RxString storageImageURL = ''.obs;
  String writedName = '';
  RxBool isSample = true.obs;
  RxBool imageChanged = false.obs;
  RxList<bool?> isSelected = [false].obs;
  RxList<Map<String, String>> selectedMembersInfo = <Map<String, String>>[].obs;
  RxString favoriteGroupName = ''.obs;
  RxString favoriteGroupImage = ''.obs;
  RxList<dynamic> favoriteGroupMembers = <dynamic>[].obs;

  final Reference _storageREF = _firebaseStorage
      .ref()
      .child('user')
      .child('${_auth.currentUser?.uid}')
      .child('groups');

  final CollectionReference _firestoreREF = _firestore
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('groups');

  getGroupImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(
      source: source,
      maxHeight: 1260,
      maxWidth: 1260,
    );

    pickedImage(ximage!.path);
    isSample(false);

    Get.back();
  }

  getGroupColor(Color color) {
    pickedColor(color);
    pickedColorValue = pickedColor.value.value;
  }

  setToFavorite(String name) async {
    var querySnapshot = await _firestoreREF.get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        'favorite': false,
      });
    }

    await _firestoreREF.doc(name).update({
      'favorite': true,
      'timeStamp': Timestamp.now(),
    });

    findFavoite();
  }

  findFavoite() {
    _firestoreREF
        .where('favorite', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        favoriteGroupName(element['name']);
        favoriteGroupImage(element['image']);
        favoriteGroupMembers(element['members']);
      });
    });
  }

  pickForRecord(String name) async {
    var querySnapshot = await _firestoreREF.get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.set(
        {'picked': false},
        SetOptions(merge: true),
      );
    }

    await _firestoreREF.doc(name).update({
      'picked': true,
      'timeStamp': Timestamp.now(),
    });
  }

  uploadGroupFirebase() async {
    Get.put(UserDataController());

    selectedMembersInfo.add(
      {
        'name': Get.find<UserDataController>().displayNameFS.value,
        'image': Get.find<UserDataController>().profileImageFS.value,
      },
    );

    await storageUploader(writedName, pickedImage.value);
    await firestoreUploader(
      writedName,
      isSample.value ? _defaultImageURL : storageImageURL.value,
      pickedColorValue,
      selectedMembersInfo,
    );

    for (var selectedMember in selectedMembersInfo) {
      addGroupToFriendsInfo(selectedMember['name']!, [writedName]);
    }

    QuerySnapshot querySnapshot = await _firestoreREF.get();
    int docsLength = querySnapshot.docs.length;
    if (docsLength <= 1) {
      await setToFavorite(writedName);
    }

    isSelected.clear();
    selectedMembersInfo.clear();
    isSample(true);
    showToast("'$writedName'의 정보가 업데이트 되었습니다");
  }

  storageUploader(String name, String image) async {
    Reference refSelected =
        _storageREF.child(name).child('representative_image');
    if (!isSample.value) {
      File groupImage = File(image);

      UploadTask uploadTask = refSelected.putFile(groupImage);

      await uploadTask.whenComplete(() => null);

      String downloadURL = await refSelected.getDownloadURL();
      storageImageURL(downloadURL);
    }
  }

  firestoreUploader(String name, String image, int colorValue, List members) {
    _firestoreREF.doc(name).set({
      'name': name,
      'image': image,
      'color': colorValue,
      'members': members,
      'favorite': false,
      'picked': false,
      'timeStamp': Timestamp.now(),
    });
  }

  updateTimeStamp(String name) {
    _firestoreREF.doc(name).update({
      'timeStamp': Timestamp.now(),
    });
  }

  addGroupToFriendsInfo(
    String friend,
    List<String> groupNames,
  ) async {
    CollectionReference _ref = _firestore
        .collection('userData')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('friends');

    await _ref.doc(friend).update(
      {'groups': FieldValue.arrayUnion(groupNames)},
    );
  }

  refreshUserProfileImage(String newImagePath) async {
    Get.put(UserDataController());
    String oldImagePath = Get.find<UserDataController>().profileImageFS.value;
    List<Map<String, String>> removeUserProfile = [];
    List<Map<String, String>> updateUserProfile = [];

    removeUserProfile.add({
      'name': Get.find<UserDataController>().displayNameFS.value,
      'image': oldImagePath
    });

    updateUserProfile.add({
      'name': Get.find<UserDataController>().displayNameFS.value,
      'image': newImagePath
    });

    var querySnapshots = await _firestoreREF.get();

    for (var doc in querySnapshots.docs) {
      await doc.reference.update(
        {'members': FieldValue.arrayRemove(removeUserProfile)},
      );

      await doc.reference.update(
        {'members': FieldValue.arrayUnion(updateUserProfile)},
      );
    }
  }

  @override
  void onInit() {
    findFavoite();
    firestoreQuery =
        _firestoreREF.orderBy('timeStamp', descending: true).snapshots();

    super.onInit();
  }
}
