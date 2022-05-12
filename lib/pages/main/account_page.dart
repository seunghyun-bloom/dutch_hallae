import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/bank_account_controller.dart';
import 'package:dutch_hallae/utilities/dialog.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//TODO: code refactoring with getx controller
//TODO: create new getx controller

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _getxBank = Get.put(BankAccountController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  var dropdownValue = '카카오';
  final _bankList = [
    'KB국민',
    '신한',
    '하나',
    '우리',
    '카카오',
    '케이뱅크',
    '토스',
    'IBK기업',
    'SC제일',
    '씨티',
    'NH농협',
    '농협중앙회',
    'KDB산업',
    '부산',
    '경남',
    '대구',
    '광주',
    '전북',
    '제주',
    '우체국',
    '새마을금고',
    '수협',
    '수협중앙회',
    '신협중앙회',
  ];
  late Stream<QuerySnapshot> _firestoreQuery;

  @override
  void initState() {
    _firestoreQuery = _firestore
        .collection('userData')
        .doc(_auth.currentUser?.uid)
        .collection('bankAccount')
        .snapshots();
    super.initState();
  }

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
              StreamBuilder<QuerySnapshot>(
                  stream: _firestoreQuery,
                  builder: (context, snapshot) {
                    if (snapshot.data?.docs.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(38.0),
                        child: Center(
                          child: Text(
                            '계좌를 추가해보세요.',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: InkWell(
                              onTap: () {
                                print(
                                    snapshot.data?.docs[index]['accountName']);
                              },
                              onLongPress: () {
                                DialogByPlatform(
                                  title: '계좌정보 삭제',
                                  content:
                                      '${snapshot.data?.docs[index]['accountName']} 계좌정보를 삭제하시겠습니까?',
                                  onTap: () {
                                    _firestore
                                        .collection('userData')
                                        .doc(_auth.currentUser?.uid)
                                        .collection('bankAccount')
                                        .doc(snapshot.data?.docs[index]
                                            ['accountName'])
                                        .delete();
                                    Get.back();
                                  },
                                  context: context,
                                );
                              },
                              child: Container(
                                color:
                                    Colors.blueGrey.shade200.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: snapshot.data?.docs[index]
                                                ['favorite']
                                            ? Icon(
                                                Icons.star_rounded,
                                                color: Colors.yellow.shade700,
                                              )
                                            : const Icon(
                                                Icons.star_border_rounded),
                                        color: Colors.grey,
                                        iconSize: 25.h,
                                        onPressed: () {
                                          _getxBank.setToFavorite(snapshot.data
                                              ?.docs[index]['accountName']);
                                        },
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data?.docs[index]
                                                    ['accountName'],
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '  (예금주: ${snapshot.data?.docs[index]['holder']})',
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['bank'],
                                                  style: TextStyle(
                                                    color: Colors.indigo,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                                Text(
                                                  '  ${snapshot.data?.docs[index]['number']}',
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              SizedBox(
                // width: MediaQuery.of(context).size.width,
                height: 50.h,
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
                              width: 100.h,
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
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                      width: 80.w,
                                      child: Center(
                                        child: DropdownButtonFormField(
                                          isExpanded: true,
                                          value: dropdownValue,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.indigo),
                                          items: _bankList
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child:
                                                    Center(child: Text(value)),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                      width: 80.w,
                                      child: const Center(
                                        child: Text('예금주'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                      width: 120.w,
                                      child: TextField(
                                        controller: accountNumberController,
                                        decoration: const InputDecoration(
                                          hintText: '111-1111-11111',
                                        ),
                                        style: TextStyle(fontSize: 13.sp),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(signed: true),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                      width: 120.w,
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
                              child: const Text('등록'),
                              style: kRoundedButtonStyle,
                              onPressed: () {
                                Get.back();
                                _getxBank.createAccountInfo(
                                  accountNameController.text,
                                  dropdownValue,
                                  accountNumberController.text,
                                  accountHolderController.text,
                                );
                              },
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
