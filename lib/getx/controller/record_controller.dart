import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
const defaultImage =
    'https://i.pinimg.com/originals/8d/39/1e/8d391ec44771787d58daff9107742e71.png';

//TODO: firestore_records 에 그룹고유색, 총금액 입력

class RecordController extends GetxController {
  late Stream<QuerySnapshot> firestoreQuery;
  late Stream<QuerySnapshot> firestoreQuery2;
  // late Stream<DocumentSnapshot> firestoreQuery3;
  RxString title = ''.obs;
  RxInt totalAmount = 0.obs;
  RxList<bool?> isSelectedMember = <bool>[].obs;
  RxList<Map<String, String>> selectedMembersInfo = <Map<String, String>>[].obs;
  DateTime meetingDateTime = DateTime(2000, 01, 01);
  RxString group = ''.obs;
  int groupColor = 0;
  RxString pickedImage = ''.obs;
  Map<String, dynamic> place = <String, dynamic>{};
  String storageImageURL = '';
  RxString groupImage = ''.obs;
  RxString groupMembers = ''.obs;
  RxMap<String, dynamic> recordGroup = <String, dynamic>{}.obs;

  final Reference _storageREF = _firebaseStorage
      .ref()
      .child('user')
      .child('${_auth.currentUser?.uid}')
      .child('records');

  final CollectionReference firestoreREF = _firestore
      .collection('userData')
      .doc(_auth.currentUser?.uid)
      .collection('records');

  getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? ximage = await _picker.pickImage(source: source);

    if (ximage == null) {
      return;
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      maxHeight: 720,
      maxWidth: 720,
      sourcePath: ximage.path,
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

  resetAllRecordData() {
    resetPickedGroup();
    resetSelectedMembers();
    title('');
    totalAmount(0);
    group('');
    pickedImage('');
    place.clear();
    meetingDateTime = DateTime(2000, 01, 01);
  }

  findGroupColor(String group) {
    DocumentReference docRef = _firestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .collection('groups')
        .doc(group);

    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      groupColor = data['color'];
    });
  }

  findGroupImage(String group) async {
    DocumentReference docRef = _firestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .collection('groups')
        .doc(group);

    await docRef.get().then((DocumentSnapshot doc) {
      var data = doc.data() as Map<String, dynamic>;
      groupImage(data['image']);
    });
  }

  findGroupMembers(String group) {
    DocumentReference docRef = _firestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .collection('groups')
        .doc(group);

    docRef.get().then((DocumentSnapshot doc) {
      var data = doc.data() as Map<String, dynamic>;
      List value = data['members'];
      groupMembers('${value[0]['name']} 외 ${value.length - 1}명');
    });
  }

  getGroupByRecord(String group) async {
    recordGroup.clear();
    final _getxGroup = Get.put(GroupController());
    await _getxGroup.firestoreREF
        .where('name', isEqualTo: group)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        recordGroup.addAll({
          'name': element['name'],
          'image': element['image'],
          'favorite': element['favorite'],
          'members': element['members'],
          'color': element['color'],
          'createdDate': element['createdDate'],
        });
      }
    });
  }

  bool nullCheck() {
    if (title.value == '') {
      showToast('제목을 입력해주세요');
      return false;
    }

    if (group.value == '') {
      showToast('모임을 선택해주세요');
      return false;
    }

    if (selectedMembersInfo.isEmpty) {
      showToast('함께한 친구를 추가해주세요');
      return false;
    }

    if (place.isEmpty) {
      showToast('만남장소를 선택해주세요');
      return false;
    }

    if (meetingDateTime == DateTime(2000, 01, 01)) {
      showToast('날짜를 선택해주세요');
      return false;
    }

    return true;
  }

  uploadRecordFirebase() async {
    await findGroupColor(group.value);
    await storageUploader(group.value, title.value, pickedImage.value);
    await firestoreUploader(
      title.value,
      group.value,
      storageImageURL,
      selectedMembersInfo,
      place,
      totalAmount.value,
      groupColor,
      meetingDateTime,
    );
  }

  storageUploader(String groupName, String title, String image) async {
    Reference refSelected =
        _storageREF.child(groupName).child('${meetingDateTime}_$title');
    if (pickedImage.value != '') {
      File groupImage = File(image);

      UploadTask uploadTask = refSelected.putFile(groupImage);

      await uploadTask.whenComplete(() => null);

      String downloadURL = await refSelected.getDownloadURL();
      storageImageURL = downloadURL;
    } else {
      storageImageURL = defaultImage;
    }
  }

  firestoreUploader(String title, String group, String image, List members,
      Map place, int amount, int groupColor, DateTime meetingDateTime) {
    firestoreREF.doc('${meetingDateTime}_$title').set({
      'title': title,
      'group': group,
      'image': image,
      'members': members,
      'place': place,
      'amount': amount,
      'groupColor': groupColor,
      'timeStamp': meetingDateTime,
    });
  }

  @override
  void onInit() {
    firestoreQuery =
        firestoreREF.orderBy('timeStamp', descending: true).snapshots();
    firestoreQuery2 =
        firestoreREF.orderBy('timeStamp', descending: true).snapshots();
    super.onInit();
  }
}
