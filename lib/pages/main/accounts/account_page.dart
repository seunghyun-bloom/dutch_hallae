import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/pages/main/accounts/account_add.dart';
import 'package:dutch_hallae/pages/main/accounts/account_contents.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:dutch_hallae/utilities/buttons.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountPage extends GetView<BankAccountController> {
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계좌 정보 관리'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: controller.firestoreQuery,
                builder: (context, snapshot) {
                  if (snapshot.data?.docs.length == 0) {
                    return NoDataSquare(
                      titleString: '계좌를 추가해 주세요',
                      contentString: '등록된 계좌가 아직 없으시네요\n네모 박스를 눌러 계좌를 추가해 주세요',
                      onTap: () => CreateAccount(context: context),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return AccountInfoCard(
                              accountName: snapshot.data?.docs[index]
                                  ['accountName'],
                              accountHolder: snapshot.data?.docs[index]
                                  ['holder'],
                              accountNumber: snapshot.data?.docs[index]
                                  ['number'],
                              bank: snapshot.data?.docs[index]['bank'],
                              favorite: snapshot.data?.docs[index]['favorite'],
                            );
                          },
                        ),
                        SizedBox(height: 4.h),
                        StretchedButton(
                          color: Palette.basicBlue,
                          title: '계좌 추가',
                          onTap: () => CreateAccount(context: context),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
