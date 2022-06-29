import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        color: Palette.basicYellow,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => controller.setToFavorite(accountName),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    Icons.star_rounded,
                    color:
                        favorite ? Colors.white : Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(bank),
                  const SizedBox(width: 5),
                  Text(accountHolder),
                  SizedBox(
                    width: 140.w,
                    child: Text(
                      ' $accountNumber',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    accountName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                    child: ElevatedButton(
                      child: const Text(
                        '삭제',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
