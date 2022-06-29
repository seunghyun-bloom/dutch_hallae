import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/pages/main/accounts/account_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainAccountComponent extends GetView<BankAccountController> {
  dynamic onTap;
  MainAccountComponent({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => controller.accountNameFS.value == ''
                    ? const Text('대표계좌가 없어요')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(6),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.white.withOpacity(0.3),
                          //         borderRadius: BorderRadius.circular(50)),
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 12,
                          //       vertical: 6,
                          //     ),
                          //     child: const Text('대표'),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Text(
                                  controller.bankFS.value,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  '  ${controller.accountNumberFS.value}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              '${controller.accountHolderFS.value}님의 통장',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
