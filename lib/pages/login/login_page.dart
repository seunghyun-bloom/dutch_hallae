import 'package:dutch_hallae/firebase/social_login/apple_login.dart';
import 'package:dutch_hallae/firebase/social_login/facebook_login.dart';
import 'package:dutch_hallae/firebase/social_login/google_login.dart';
import 'package:dutch_hallae/firebase/social_login/twitter_login.dart';
import 'package:dutch_hallae/pages/login/email_login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dutch_hallae/utilities/login_button.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

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
              const Hero(
                tag: 'logo',
                child: FaIcon(
                  FontAwesomeIcons.moneyBillWave,
                  size: 100,
                  color: Colors.green,
                ),
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
                  LoginButton(
                    platform: 'email',
                    color: Colors.blueGrey,
                    fontColor: Colors.white,
                    onTap: () => Get.to(() => EmailLoginPage()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}