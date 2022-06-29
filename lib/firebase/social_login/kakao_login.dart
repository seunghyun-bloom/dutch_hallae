import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:http/http.dart' as http;

bool isLogined = false;
kakao.UserApi kakaoUserApi = kakao.UserApi.instance;
kakao.User? user;
const String cloudFunctionURL =
    'https://asia-northeast3-dutchhallae.cloudfunctions.net/createCustomToken';
final _getxUser = Get.put(UserDataController());

signInWithKakao(BuildContext context) async {
  await loginWithKakaoAPI();
  if (!isLogined) {
    return;
  }
  Loading(context);
  user = await kakaoUserApi.me();
  final token = await createCustomToken({
    'uid': user!.id.toString(),
    'displayName': user!.kakaoAccount!.profile!.nickname,
    'email': user!.kakaoAccount!.email!,
    'photoURL': user!.kakaoAccount!.profile!.profileImageUrl!,
  });

  await FirebaseAuth.instance.signInWithCustomToken(token);
  Get.back();
  return _getxUser.createFirestoreData();
}

Future loginWithKakaoAPI() async {
  if (await kakao.isKakaoTalkInstalled()) {
    try {
      await kakaoUserApi.loginWithKakaoTalk();
      isLogined = true;
    } catch (error) {
      isLogined = false;
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      try {
        await kakaoUserApi.loginWithKakaoAccount();
        isLogined = true;
      } catch (error) {
        isLogined = false;
      }
    }
  } else {
    try {
      await kakaoUserApi.loginWithKakaoAccount();
      isLogined = true;
    } catch (error) {
      isLogined = false;
    }
  }
}

Future<String> createCustomToken(Map<String, dynamic> user) async {
  final customTokenResponse =
      await http.post(Uri.parse(cloudFunctionURL), body: user);
  return customTokenResponse.body;
}

void signOut() async {
  await kakaoUserApi.logout();
  await FirebaseAuth.instance.signOut();
  isLogined = false;
}
