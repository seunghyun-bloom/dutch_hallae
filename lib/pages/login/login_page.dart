import 'package:dutch_hallae/firebase/social_login/apple_login.dart';
import 'package:dutch_hallae/firebase/social_login/facebook_login.dart';
import 'package:dutch_hallae/firebase/social_login/google_login.dart';
import 'package:dutch_hallae/firebase/social_login/kakao_login.dart';
import 'package:dutch_hallae/firebase/social_login/twitter_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                height: Get.width * 0.7,
                child: Image.asset('assets/images/halle_team_logo.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '안녕하세요 모임장님\n먼저 소셜 로그인을 해주세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                        platform: 'Kakao',
                        color: Colors.amber.shade200,
                        onTap: () => signInWithKakao(context),
                      ),
                      LoginButton(
                        platform: 'Google',
                        color: Colors.white,
                        onTap: () => signInWithGoogle(context),
                      ),
                      LoginButton(
                        platform: 'facebook',
                        color: Color(0xff475993),
                        onTap: () => signInWithFacebook(context),
                      ),
                      LoginButton(
                        platform: 'twitter',
                        color: Color(0xff50ABF1),
                        onTap: () => signInWithTwitter(context),
                      ),
                      Platform.isIOS
                          ? LoginButton(
                              platform: 'apple',
                              color: Colors.white,
                              onTap: () => signInWithApple(context),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(height: 30.h)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
