import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/getx/controller/user_data_controller.dart';
import 'package:dutch_hallae/pages/main/components/main_drawer.dart';
import 'package:dutch_hallae/pages/main/components/main_group.dart';
import 'package:dutch_hallae/pages/main/components/main_record.dart';
import 'package:dutch_hallae/pages/main/components/main_title.dart';
import 'package:dutch_hallae/pages/main/groups/group_page.dart';
import 'package:dutch_hallae/pages/main/record/record_create_page.dart';
import 'package:dutch_hallae/pages/main/record/record_page.dart';
import 'package:dutch_hallae/utilities/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _getxUser = Get.put(UserDataController());
  final _getxBank = Get.put(BankAccountController());

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/halle_team_logo.png',
          height: 80.h,
        ),
      ),
      drawer: mainDrawerMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                ContentsTitle(
                  title: '즐겨 사용하는 모임',
                  onTap: () => Get.to(() => const GroupPage()),
                ),
                const MainGroupComponent(),
                ContentsTitle(
                  title: '지난 만남 기록',
                  subTitle: '지난 만남들이 기록되어 있습니다.',
                  onTap: () => Get.to(() => const RecordPage()),
                ),
                const MainRecordComponent(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 100.0,
        children: [
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.calculate_outlined),
          ),
          ActionButton(
            onPressed: () => Get.to(() => RecordCreatePage()),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
