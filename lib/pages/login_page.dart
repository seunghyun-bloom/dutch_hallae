import 'package:dutch_hallae/firebase/social_login/apple_login.dart';
import 'package:dutch_hallae/firebase/social_login/facebook_login.dart';
import 'package:dutch_hallae/firebase/social_login/google_login.dart';
import 'package:dutch_hallae/firebase/social_login/twitter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dutch_hallae/utilities/login_button.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const FaIcon(
                FontAwesomeIcons.moneyBillWave,
                size: 100,
                color: Colors.green,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(
                    platform: 'Google',
                    color: Colors.red.shade100,
                    onTap: () => signInWithGoogle(),
                  ),
                  LoginButton(
                    platform: 'facebook',
                    color: Colors.blueAccent.shade100,
                    onTap: () => signInWithFacebook(),
                  ),
                  LoginButton(
                    platform: 'twitter',
                    color: Colors.lightBlue.shade100,
                    onTap: () => signInWithTwitter(),
                  ),
                  LoginButton(
                    platform: 'apple',
                    color: Colors.white,
                    onTap: () => Platform.isIOS
                        ? signInWithApple()
                        : showToast('iOS에서만 사용할 수 있습니다.'),
                  ),
                ],
              ),
              TextButton(
                child: Text(
                  'Guest로 시작하기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red[800],
                  ),
                ),
                onPressed: () async {
                  UserCredential userCredential =
                      await _auth.signInAnonymously();
                  userCredential;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
