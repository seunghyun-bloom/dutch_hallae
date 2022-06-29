import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RecordController extends GetxController {
  late Stream<QuerySnapshot> firestoreQuery;
  RxString title = ''.obs;
  RxInt totalAmount = 0.obs;
  RxInt personalAmount = 0.obs;
  RxList<String> members = <String>[].obs;
  RxList<String> specialMembers = <String>[].obs;
  RxString group = ''.obs;

  tempFunction() {}
}
