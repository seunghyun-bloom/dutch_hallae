import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/pages/main/accounts/account_add.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/toast.dart';
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
  dynamic onTap = () {};
  AccountInfoCard({
    Key? key,
    required this.accountName,
    required this.accountHolder,
    required this.accountNumber,
    required this.bank,
    required this.favorite,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black87),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
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
                                Text(
                                  '  (예금주: $accountHolder)',
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
                                    color: Colors.indigo,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  '  $accountNumber',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 150.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: StretchedButton(
                                    color: Colors.blue.shade300,
                                    title: '수정하기',
                                    onTap: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: StretchedButton(
                                    color: Colors.red.shade300,
                                    title: '삭제하기',
                                    onTap: () {
                                      DialogByPlatform(
                                        title: '계좌정보 삭제',
                                        content: '$accountName 계좌정보를 삭제하시겠습니까?',
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
                          );
                        },
                      );
                    },
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
