import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserDataController extends GetxController {
  RxString profileImageFS = ''.obs;
  RxString displayNameFS = ''.obs;
  RxString emailFS = ''.obs;
  RxString uidFS = ''.obs;

  createFirestoreData() {
    _firestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        await createVariables(
          value['profileImage'].toString(),
          value['displayName'].toString(),
          value['email'].toString(),
          value['uid'].toString(),
        );
      } else {
        await _firestore.collection('userData').doc(_auth.currentUser?.uid).set(
          {
            'displayName': _auth.currentUser?.displayName,
            'email': _auth.currentUser?.email,
            'profileImage': _auth.currentUser?.photoURL,
            'uid': _auth.currentUser?.uid,
          },
        );
        await createVariables(
          value['profileImage'].toString(),
          value['displayName'].toString(),
          value['email'].toString(),
          value['uid'].toString(),
        );
      }
    });
  }

  createVariables(
      String profileimage, String displayname, String email, String uid) {
    profileImageFS(profileimage);
    displayNameFS(displayname);
    emailFS(email);
    uidFS(uid);
  }

  changeProfileImage(String value) {
    profileImageFS(value);
  }

  changeDisplayName(String value) {
    displayNameFS(value);
  }

  @override
  void onInit() {
    createFirestoreData();
    super.onInit();
  }
}
