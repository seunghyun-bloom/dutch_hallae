import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/record/contents/date_picker.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_friends_selector.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_image_picker.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:flutter/material.dart';
import 'package:dutch_hallae/getx/controller/place_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/record/contents/mini_map.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_group_picker.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_place_searcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordCreatePage extends StatelessWidget {
  RecordCreatePage({Key? key}) : super(key: key);

  final TextEditingController _titleTextController = TextEditingController();
  final _getxRecord = Get.put(RecordController());
  final _getxPlace = Get.put(PlaceController());
  final _getxGroup = Get.put(GroupController());
  var numberFormat = NumberFormat('###,###,###,###');
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    Get.put(PlaceController());
    Get.put(GroupController());
    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('기록하기'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('제목', style: fontSize20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      focusNode: focusNode,
                      controller: _titleTextController,
                      onChanged: (value) {
                        _getxRecord.title.value = value;
                      },
                      maxLength: 10,
                      decoration: const InputDecoration(
                        hintText: 'ex) 베프 생일 기념',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text('모임 선택하기', style: fontSize20),
                  ),
                  RecordGroupPicker(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text('함께한 친구', style: fontSize20),
                  ),
                  InkWell(
                      onTap: () => _getxRecord.selectedMembersInfo.isEmpty
                          ? showToast('모임을 먼저 선택해주세요')
                          : SelectMemberPopup(
                              context: context,
                              groupName: _getxRecord.group.value,
                            ),
                      child: const ShowingSelectedMembers()),
                  const SizedBox(height: 20),
                  Text('장소', style: fontSize20),
                  Container(
                    width: Get.mediaQuery.size.width,
                    height: 40.h,
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: ElevatedButton(
                      style: whiteElevatedStyle,
                      child: Text(
                        _getxPlace.pickedPlace.isEmpty
                            ? '검색해서 찾아보기'
                            : _getxPlace.pickedPlace['title'],
                      ),
                      onPressed: () => PlaceSearcher(context: context),
                    ),
                  ),
                  _getxPlace.pickedPlace.isEmpty
                      ? const SizedBox()
                      : MiniMap(
                          x: _getxPlace.pickedPlace['x'],
                          y: _getxPlace.pickedPlace['y'],
                        ),
                  const SizedBox(height: 20),
                  Text(
                    '날짜',
                    style: fontSize20,
                  ),
                  const SizedBox(height: 10),
                  const DatePicker(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      '사진',
                      style: fontSize20,
                    ),
                  ),
                  const RecordImagePicker(),
                  Padding(
                    padding: EdgeInsets.all(10.h),
                    child: StretchedButton(
                      title: '등록하기',
                      onTap: () => print(
                          '\n isSelectedMember: ${_getxRecord.isSelectedMember.length}\n selectedMembersInfo: ${_getxRecord.selectedMembersInfo.length}\n groupName: ${_getxRecord.group.value}'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
