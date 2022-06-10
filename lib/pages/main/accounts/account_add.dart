import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccount {
  BuildContext context;
  CreateAccount({required this.context}) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.scale,
      duration: const Duration(milliseconds: 300),
      builder: (BuildContext context) {
        return CreateAccountContents();
      },
    );
  }
}

class CreateAccountContents extends GetView<BankAccountController> {
  CreateAccountContents({Key? key}) : super(key: key);

  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text(
        '계좌추가',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      content: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InsertAccountInfoFrame(
              title: '계좌명',
              content: TextField(
                controller: accountNameController,
                decoration: const InputDecoration(
                  hintText: 'ex) 독서모임 회비',
                  border: InputBorder.none,
                ),
              ),
            ),
            InsertAccountInfoFrame(
              title: '예금주',
              content: TextField(
                controller: accountHolderController,
                decoration: const InputDecoration(
                  hintText: 'ex) 신짱아',
                  border: InputBorder.none,
                ),
              ),
            ),
            InsertAccountInfoFrame(
              title: '은행',
              content: Obx(
                () => DropdownButtonFormField(
                  isExpanded: true,
                  value: controller.selectedBank.value,
                  elevation: 16,
                  style: const TextStyle(color: Pantone.veryPeri),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  items: controller.bankList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: Text(value)),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    controller.selectedBank.value = value!;
                  },
                  onSaved: (String? value) {
                    controller.selectedBank.value = value!;
                  },
                ),
              ),
            ),
            InsertAccountInfoFrame(
              title: '계좌번호',
              content: TextField(
                controller: accountNumberController,
                decoration: const InputDecoration(
                  hintText: 'ex) 111-1111-11111',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 13.sp),
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
              ),
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.favoriteChecked.value,
                    onChanged: (value) =>
                        controller.favoriteChecked.value = value!,
                  ),
                ),
                Text('대표 계좌로 설정하기', style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            StretchedButton(
              color: Pantone.veryPeri,
              title: '등록',
              onTap: () {
                controller.createAccountInfo(
                  accountNameController.text,
                  accountNumberController.text,
                  accountHolderController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InsertAccountInfoFrame extends StatelessWidget {
  String title;
  Widget content;
  InsertAccountInfoFrame({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45.h,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          Container(
            height: 45.h,
            width: 180.w,
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
    );
  }
}
