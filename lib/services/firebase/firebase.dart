import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData(int number) async {
    CollectionReference numbers = FirebaseFirestore.instance.collection('numbers');
    numbers.add({"randomNumber": number});
  }

  getData() {

  }

}