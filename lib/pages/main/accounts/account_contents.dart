import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AccountInfoCard extends GetView<BankAccountController> {
  String accountName;
  String accountHolder;
  String accountNumber;
  String bank;
  bool favorite;
  AccountInfoCard({
    Key? key,
    required this.accountName,
    required this.accountHolder,
    required this.accountNumber,
    required this.bank,
    required this.favorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: favorite
                        ? Icon(
                            Icons.star_rounded,
                            color: Colors.yellow.shade700,
                          )
                        : const Icon(Icons.star_border_rounded),
                    color: Colors.grey,
                    iconSize: 25.h,
                    onPressed: () {
                      controller.setToFavorite(accountName);
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Row(
                          children: [
                            Text(
                              accountName,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              accountHolder,
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Row(
                          children: [
                            Text(
                              bank,
                              style: TextStyle(
                                color: Pantone.veryPeri,
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(
                              width: 140.w,
                              child: Text(
                                ' $accountNumber',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 60.w,
                child: TextButton(
                  child: Text(
                    '삭제',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  onPressed: () {
                    DialogByPlatform(
                      title: "'$accountName' 계좌 삭제",
                      content: '삭제하면 복구가 불가능합니다.\n그래도 삭제하시겠습니까?',
                      onTap: () {
                        controller.deleteAccount(accountName);
                        Get.back();
                      },
                      context: context,
                    );
                  },
                ),
              ),
            ],
          ),
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
                style: TextStyle(fontSize: 14.sp),
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
