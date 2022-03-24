import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

Future<UserCredential> signInWithTwitter() async {
  Get.put(UserDataController());
  // Create a TwitterLogin instance
  final twitterLogin = TwitterLogin(
      apiKey: 'tXqOgkMw3lkqqYsOZ6uhuB8DE',
      apiSecretKey: 'mIdNTqnxsMGGDb2yDr7K1JaomquTRcZ1aqgNT2Bh5Si7YPIYFk',
      redirectURI: 'twittercallback://');

  // Trigger the sign-in flow
  AuthResult authResult = await twitterLogin.login();

  // Create a credential from the access token
  AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
    accessToken: authResult.authToken!,
    secret: authResult.authTokenSecret!,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  return Get.find<UserDataController>().createFirestoreData();
}
