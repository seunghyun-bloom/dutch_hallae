import 'dart:io';

import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();

  //TODO: Hamzzy) AlertDialog 화면 예쁘게 다시 짜기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계좌 정보 관리'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.indigo.shade100,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.plusCircle),
                      Text('계좌 추가'),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('계좌정보'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextField(
                                controller: accountNameController,
                                decoration:
                                    const InputDecoration(labelText: '계좌별명'),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(
                                        height: 50,
                                        //TODO: 1) DropdownButton을 별도 위젯으로 생성
                                        child: Center(child: Text('은행명'))),
                                    SizedBox(
                                        height: 50,
                                        child: Center(child: Text('예금주'))),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: TextField(
                                        controller: accountNumberController,
                                        decoration: const InputDecoration(
                                          hintText: '계좌번호',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: TextField(
                                        controller: accountHolderController,
                                        decoration: const InputDecoration(
                                          hintText: '홍길동',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          Center(
                            child: ElevatedButton(
                              //TODO: 2) GetX reactive state management를 이용하여 data를 관리 하도록 (별도의 controller 생성)
                              onPressed: () {},
                              child: const Text('등록'),
                              style: kRoundedButtonStyle,
                            ),
                          ),
                        ],
                      ),
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
