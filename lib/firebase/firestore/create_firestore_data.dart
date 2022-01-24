import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

dynamic profileImageFS;
dynamic displayNameFS;
dynamic emailFS;
dynamic uidFS;

//TODO: 2) firestore의 doc에 uid 값이 없을 경우에만 실행되도록 수정
//TODO:    현재는 if 값이 always false라 실행이 되지 않음.
createFirestoreData() async {
  if (_firestore.collection('userData').doc(_auth.currentUser?.uid) == null) {
    await _firestore.collection('userData').doc(_auth.currentUser?.uid).set({
      'displayName': _auth.currentUser?.displayName,
      'email': _auth.currentUser?.email,
      'profileImage': _auth.currentUser?.photoURL,
      'uid': _auth.currentUser?.uid,
    });
  }
  await _firestore
      .collection('userData')
      .doc(_auth.currentUser?.uid)
      .get()
      .then((value) {
    profileImageFS = value['profileImage'];
    displayNameFS = value['displayName'];
    emailFS = value['email'];
    uidFS = value['uid'];
  });
}
//
// getFirestoreData() {
//   _firestore
//       .collection('userData')
//       .doc(_auth.currentUser?.uid)
//       .get()
//       .then((value) {
//     profileImageFS = value['profileImage'];
//     displayNameFS = value['displayName'];
//     emailFS = value['email'];
//     uidFS = value['uid'];
//   });
// }
