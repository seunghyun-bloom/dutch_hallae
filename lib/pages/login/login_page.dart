import 'package:dutch_hallae/firebase/social_login/apple_login.dart';
import 'package:dutch_hallae/firebase/social_login/facebook_login.dart';
import 'package:dutch_hallae/firebase/social_login/google_login.dart';
import 'package:dutch_hallae/firebase/social_login/kakao_login.dart';
import 'package:dutch_hallae/firebase/social_login/twitter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
                    platform: 'Kakao',
                    color: Colors.amber.shade200,
                    onTap: () => signInWithKakao(),
                  ),
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
                  Platform.isIOS
                      ? LoginButton(
                          platform: 'apple',
                          color: Colors.white,
                          onTap: () => signInWithApple(),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
