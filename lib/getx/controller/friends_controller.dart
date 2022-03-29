import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

String defaultImageURL =
    'https://firebasestorage.googleapis.com/v0/b/dutchhallae.appspot.com/o/basic%2Ffriends%2Fsample_images%2Ffriend_sample_0.jpeg?alt=media&token=3f159e77-cade-4345-8b6e-7a5d4c7e75e8';
String defaultImage = 'assets/images/friend_sample_0.jpeg';

class FriendsController extends GetxController {
  RxString friendImageURL = defaultImageURL.obs;
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
  final CollectionReference _friendsRef = _firestore
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('friends');
  final Reference _refFriends = _firebaseStorage
      .ref()
      .child('user')
      .child('${_auth.currentUser?.uid}')
      .child('friends');

  String downloadUrlTemp = '';
  RxBool isSample = true.obs;

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

  selectSampleImage(int i) {
    isSample(true);
    String selectedSampleImage = sampleFriendImages[i];
    friendImageURL(selectedSampleImage);
    showingFriendImage('assets/images/friend_sample_$i.jpeg');
  }

  uploadFriendFirestore(String name, String phone) async {
    Reference refSelected = _refFriends.child('selected_profile').child(name);

    if (isSample.value == false) {
      File friendImage = File(showingFriendImage.value);

      UploadTask uploadTask = refSelected.putFile(friendImage);

      await uploadTask.whenComplete(() => null);

      String downloadURL = await refSelected.getDownloadURL();
      friendImageURL(downloadURL);
    }

    await _friendsRef.doc(name).set({
      'name': name,
      'phone': phone,
      'image': friendImageURL.value,
    });

    Get.back();

    showToast('$name님의 정보가 업데이트 되었습니다.');

    showingFriendImage(defaultImage);
    isSample(true);
  }
}
