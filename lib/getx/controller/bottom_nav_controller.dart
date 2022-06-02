import 'dart:io';

import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum PageName { MAIN, CALENDAR, MAP, SETTING }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.MAIN:
      case PageName.CALENDAR:
      case PageName.MAP:
      case PageName.SETTING:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction(BuildContext context) async {
    if (bottomHistory.length == 1) {
      DialogByPlatform(
        title: '앱 종료',
        content: '앱을 종료하시겠습니까?',
        onTap: () => exit(0),
        context: context,
      );
      return true;
    } else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}
