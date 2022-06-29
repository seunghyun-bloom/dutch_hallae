import 'package:dutch_hallae/pages/main/friends/modal_fit.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/textfield_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final double _width = Get.width * 0.8;

class FriendsAddDirectly extends StatelessWidget {
  String name;
  FriendsAddDirectly({Key? key, required this.name}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      child: Column(
        children: [
          InsertFriendInfoFrame(
            title: '이름',
            content: TextField(
              controller: _nameController,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: name,
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          InsertFriendInfoFrame(
            title: '전화번호',
            content: TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              maxLength: 13,
              inputFormatters: [phoneNumberFormat],
              decoration: const InputDecoration(
                hintText: 'ex) 010-XXXX-XXXX',
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            width: _width,
            child: StretchedButton(
                title: '등록하기',
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => ModalFit(
                      friend: _nameController.value.text == ''
                          ? name
                          : _nameController.value.text,
                      phone: _numberController.value.text,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class InsertFriendInfoFrame extends StatelessWidget {
  String title;
  Widget content;
  InsertFriendInfoFrame({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 45.h,
              width: _width * 0.3,
              child: Center(
                child: Text(
                  title,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Container(
              height: 45.h,
              width: _width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
