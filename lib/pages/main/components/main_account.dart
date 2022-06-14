import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/pages/main/accounts/account_page.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//TODO: 계좌 없을시 화면 완성

class MainAccountComponent extends GetView<BankAccountController> {
  const MainAccountComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: kShape20,
      child: InkWell(
        onTap: () => Get.to(() => AccountPage()),
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
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('대표계좌'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Pantone.veryPeri),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(Size.square(35.sp)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Text(
                                  controller.bankFS.value,
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Text(
                                  '  ${controller.accountNumberFS.value}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
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
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
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
