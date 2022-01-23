import 'package:dutch_hallae/firebase/firestore/create_firestore_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

Future<UserCredential> signInWithTwitter() async {
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
  return await createFirestoreData();
}
