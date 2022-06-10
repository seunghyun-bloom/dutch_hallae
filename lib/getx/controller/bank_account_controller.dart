import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BankAccountController extends GetxController {
  final CollectionReference _accountRef = FirebaseFirestore.instance
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('bankAccount');
  RxString accountNameFS = ''.obs;
  RxString bankFS = ''.obs;
  RxString accountNumberFS = ''.obs;
  RxString accountHolderFS = ''.obs;
  late Stream<QuerySnapshot> firestoreQuery;
  List<String> bankList = [
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
  RxString selectedBank = '카카오'.obs;
  RxBool favoriteChecked = false.obs;

  createAccountInfo(String name, String number, String holder) async {
    await _accountRef.doc(name).set({
      'accountName': name,
      'bank': selectedBank.value,
      'number': number,
      'holder': holder,
      'favorite': false,
    });

    if (favoriteChecked.value) {
      await setToFavorite(name);
    }

    QuerySnapshot querySnapshot = await _accountRef.get();
    int docsLength = querySnapshot.docs.length;

    if (docsLength <= 1) {
      accountNameFS(name);
      bankFS(selectedBank.value);
      accountNumberFS(number);
      accountHolderFS(holder);
    } else {
      print('variable did not changed');
    }
    favoriteChecked(false);
    Get.back();
  }

  setToFavorite(String name) async {
    var querySnapshot = await _accountRef.get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        'favorite': false,
      });
    }
    _accountRef.doc(name).update({
      'favorite': true,
    });
    _accountRef.doc(name).get().then((value) {
      createVariable(
        value['accountName'].toString(),
        value['bank'].toString(),
        value['number'].toString(),
        value['holder'].toString(),
      );
    });
  }

  createVariable(String name, String bank, String number, String holder) {
    accountNameFS(name);
    bankFS(bank);
    accountNumberFS(number);
    accountHolderFS(holder);
  }

  findFavorite() async {
    _accountRef
        .where('favorite', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        createVariable(
          element['accountName'].toString(),
          element['bank'].toString(),
          element['number'].toString(),
          element['holder'].toString(),
        );
      });
    });
    print('findFavoite() called');
  }

  deleteAccount(String path) async {
    await _accountRef.doc(path).delete();
    Get.back();
  }

  @override
  void onInit() {
    findFavorite();
    firestoreQuery = _accountRef.snapshots();
    super.onInit();
  }
}
