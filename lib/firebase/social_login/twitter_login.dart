import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:dutch_hallae/utilities/secret_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

Future<UserCredential> signInWithTwitter(BuildContext context) async {
  final _getxUser = Get.put(UserDataController());
  // Create a TwitterLogin instance
  final twitterLogin = TwitterLogin(
      apiKey: twitterApiKey,
      apiSecretKey: twitterApiSecretKey,
      redirectURI: 'twittercallback://');

  // Trigger the sign-in flow
  AuthResult authResult = await twitterLogin.login();

  Loading(context);

  // Create a credential from the access token
  AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
    accessToken: authResult.authToken!,
    secret: authResult.authTokenSecret!,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  Get.back();
  return _getxUser.createFirestoreData();
}
