import 'package:dutch_hallae/getx/controller/bottom_nav_controller.dart';
import 'package:dutch_hallae/pages/calendar/calendar_page.dart';
import 'package:dutch_hallae/pages/login/login_page.dart';
import 'package:dutch_hallae/pages/main/main_page.dart';
import 'package:dutch_hallae/pages/map/map_page.dart';
import 'package:dutch_hallae/pages/settings/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/toast.dart';

class RouteManager extends GetView<BottomNavController> {
  RouteManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController());
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data == null) {
          return LoginPage();
        } else {
          return WillPopScope(
            onWillPop: () async {
              return controller.willPopAction(context);
            },
            child: Obx(
              () => Scaffold(
                body: IndexedStack(
                  index: controller.pageIndex.value,
                  children: [
                    MainPage(),
                    CalendarPage(),
                    MapPage(),
                    UserProfilePage(),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  notchMargin: 6,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    currentIndex: controller.pageIndex.value,
                    onTap: controller.changeBottomNav,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book_outlined),
                        activeIcon: Icon(Icons.book),
                        label: '메인',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_today_outlined),
                        activeIcon: Icon(Icons.calendar_today),
                        label: '캘린더',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map_outlined),
                        activeIcon: Icon(Icons.map),
                        label: '지도',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        activeIcon: Icon(Icons.settings),
                        label: '설정',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
