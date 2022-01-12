import 'package:dutch_hallae/firebase/social_login/facebook_login.dart';
import 'package:dutch_hallae/firebase/social_login/google_login.dart';
import 'package:dutch_hallae/pages/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  //TODO: insert StreamBuilder with FirebaseAuth.instance.userChanges()
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              radius: 80,
              child: Text('LOGO'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Card(
                    child: ListTile(
                      leading: Image.asset('assets/images/google_logo.png'),
                      title: Text('Google 로그인 하기'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  onTap: () => signInWithGoogle(),
                ),
                InkWell(
                  child: Card(
                    child: ListTile(
                      leading: Image.asset('assets/images/facebook_logo.png'),
                      title: Text('facebook 로그인 하기'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  onTap: () => signInWithFacebook(),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/twitter_logo.png'),
                    title: Text('twitter 로그인 하기'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/apple_logo.png'),
                    title: Text('apple로 로그인 하기'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
            InkWell(
              child: Text(
                'Guest로 시작하기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[800],
                ),
              ),
              onTap: () async {
                UserCredential userCredential = await _auth.signInAnonymously();
                userCredential;
              },
            ),
          ],
        ),
      ),
    );
  }
}
