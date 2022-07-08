import 'package:dutch_hallae/getx/controller/place_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/components/main_account.dart';
import 'package:dutch_hallae/pages/main/record/contents/mini_map.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_group_picker.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_place_searcher.dart';
import 'package:dutch_hallae/utilities/insert_info_frame.dart';
import 'package:dutch_hallae/utilities/textfield_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class RecordCreatePage extends StatelessWidget {
  RecordCreatePage({Key? key}) : super(key: key);

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _totalAmountTextController =
      TextEditingController();
  final TextEditingController _specialDCTextController =
      TextEditingController();
  List members = ['김채원', '사쿠라', '홍은채', '카즈하', '허윤진'];
  final _getxRecord = Get.put(RecordController());
  final _getxPlace = Get.put(PlaceController());
  var numberFormat = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    Get.put(PlaceController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록하기'),
        actions: [
          TextButton(
            child: Text('print'),
            onPressed: () async {
              print(_getxPlace.pickedPlace['x']);
              print(_getxPlace.pickedPlace['y']);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('정산 모임 선택하기'),
                RecordGroupPicker(),
                InsertInfoFrame(
                  title: '제목',
                  fontSize: 18,
                  height: 40,
                  content: TextField(
                    controller: _titleTextController,
                    onChanged: (value) {
                      _getxRecord.title.value = value;
                    },
                    maxLength: 8,
                    decoration: const InputDecoration(
                      hintText: 'ex) 1차 치맥',
                      border: InputBorder.none,
                      counterText: "",
                    ),
                  ),
                ),
                InsertInfoFrame(
                  title: '장소',
                  fontSize: 18,
                  height: 40,
                  content: TextButton(
                    child: _getxPlace.pickedPlace.isEmpty
                        ? const Text('검색해서 찾아보기')
                        : Text(_getxPlace.pickedPlace['title']),
                    onPressed: () => PlaceSearcher(context: context),
                  ),
                ),
                _getxPlace.pickedPlace.isEmpty
                    ? const SizedBox()
                    : MiniMap(
                        x: _getxPlace.pickedPlace['x'],
                        y: _getxPlace.pickedPlace['y'],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
