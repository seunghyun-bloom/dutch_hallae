import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

Future<UserCredential> signInWithFacebook(BuildContext context) async {
  final _getxUser = Get.put(UserDataController());
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();
  Loading(context);

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  Get.back();
  return _getxUser.createFirestoreData();
}
