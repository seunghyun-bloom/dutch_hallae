import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/firebase/firestore/create_firestore_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

//TODO: 1) iOS에서 이미지 업로드 안되는 문제 해결
uploadImageToStorage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? ximage = await _picker.pickImage(
    source: source,
    maxHeight: 200,
    maxWidth: 200,
  );
  File image = File(ximage!.path);

  // Determine the path and file name of the uploading profile image
  // Remove the possibility of duplicating the file name using the user's uid.
  Reference reference = _firebaseStorage
      .ref()
      .child('profile')
      .child('${_auth.currentUser?.uid}');

  // Upload file to Firebase storage
  UploadTask uploadTask = reference.putFile(image);

  // wait until upload completed
  await uploadTask.whenComplete(() => null);

  // get uploaded url
  String downloadURL = await reference.getDownloadURL();

  await _firebaseFirestore
      .collection('userData')
      .doc(_auth.currentUser?.uid)
      .update({'profileImage': downloadURL});

  profileImageFS = downloadURL;

  Get.back();
}