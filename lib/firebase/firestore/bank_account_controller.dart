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

  createAccountInfo(
      String name, String bank, String number, String holder) async {
    _accountRef.doc(name).set({
      'accountName': name,
      'bank': bank,
      'number': number,
      'holder': holder,
      'favorite': false,
    });
    QuerySnapshot querySnapshot = await _accountRef.get();
    int docsLength = querySnapshot.docs.length;
    if (docsLength <= 1) {
      accountNameFS(name);
      bankFS(bank);
      accountNumberFS(number);
      accountHolderFS(holder);
      print('variable changed');
    } else {
      print('variable did not changed');
    }
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

  @override
  void onInit() {
    findFavorite();
    super.onInit();
  }
}
