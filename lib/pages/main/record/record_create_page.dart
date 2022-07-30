import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/record/contents/date_picker.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_friends_selector.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_image_picker.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/loading.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/textfield_formatter.dart';
import 'package:dutch_hallae/utilities/title.dart';
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

class RecordCreatePage extends StatefulWidget {
  RecordCreatePage({Key? key}) : super(key: key);

  @override
  State<RecordCreatePage> createState() => _RecordCreatePageState();
}

class _RecordCreatePageState extends State<RecordCreatePage> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _totalAmountTextController =
      TextEditingController();

  final _getxRecord = Get.put(RecordController());
  final _getxPlace = Get.put(PlaceController());

  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();

  unfocusTextField() {
    focusNode.unfocus();
    focusNode2.unfocus();
  }

  @override
  void dispose() {
    _getxRecord.resetAllRecordData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());
    Get.put(PlaceController());
    return GestureDetector(
      onTap: () => unfocusTextField(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('만남 기록하기'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(title: '제목', top: 10),
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
                  TitleText(title: '모임 선택하기'),
                  RecordGroupPicker(focusNode: focusNode),
                  TitleText(title: '함께한 친구'),
                  InkWell(
                      onTap: () => _getxRecord.selectedMembersInfo.isEmpty
                          ? showToast('모임을 먼저 선택해주세요')
                          : SelectMemberPopup(
                              context: context,
                              groupName: _getxRecord.group.value,
                            ),
                      child: const ShowingSelectedMembers()),
                  const SizedBox(height: 20),
                  TitleText(title: '장소', top: 10),
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
                  TitleText(title: '총 금액 (₩)', top: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _totalAmountTextController,
                      focusNode: focusNode2,
                      onChanged: (value) {
                        var removeChars = value.replaceAll(",", "");
                        var intValue = int.tryParse(removeChars) ?? 0;
                        _getxRecord.totalAmount.value = intValue;
                      },
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      inputFormatters: [DecimalFormatter()],
                      decoration: const InputDecoration(
                        hintText: 'ex) 15,000',
                        counterText: "",
                      ),
                    ),
                  ),
                  TitleText(title: '날짜', top: 35),
                  const DatePicker(),
                  TitleText(title: '사진'),
                  const RecordImagePicker(),
                  Padding(
                    padding: EdgeInsets.all(10.h),
                    child: StretchedButton(
                      title: '등록하기',
                      onTap: () async {
                        bool passNullCheck = _getxRecord.nullCheck();
                        if (!passNullCheck) {
                          return;
                        } else {
                          Loading(context);
                          await _getxRecord.uploadRecordFirebase();
                          showToast(
                              '${_getxRecord.title.value}의 정보가 업데이트 되었습니다');
                          Get.back();
                          Get.back();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
