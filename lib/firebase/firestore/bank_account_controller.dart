import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BankAccountController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString accountNameFS = ''.obs;
  RxString bankFS = ''.obs;
  RxString accountNumberFS = ''.obs;
  RxString accountHolderFS = ''.obs;

  createAccountInfo(String name, String bank, String number, String holder) {
    _firestore
        .collection('userData')
        .doc('${_auth.currentUser?.uid}')
        .collection('bankAccount')
        .doc(name)
        .set({
      'accountName': name,
      'bank': bank,
      'number': number,
      'holder': holder,
      'favorite': false,
    });
    accountNameFS(name);
    bankFS(bank);
    accountNumberFS(number);
    accountHolderFS(holder);
    print('name : $accountNameFS');
    print('bank : $bankFS');
    print('number : $accountNumberFS');
    print('holder : $accountHolderFS');
  }

  setToFavorite(String name) async {
    var collection = _firestore
        .collection('userData')
        .doc('${_auth.currentUser?.uid}')
        .collection('bankAccount');
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        'favorite': false,
      });
    }
    collection.doc(name).update({
      'favorite': true,
    });
    collection.doc(name).get().then((value) {
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
}
