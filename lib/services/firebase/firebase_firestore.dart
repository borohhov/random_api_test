import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> addData<T>(T data) async {
    if(data is int) {
      CollectionReference numbers = FirebaseFirestore.instance.collection('numbers');
      DocumentReference documentReference = await numbers.add({"randomNumber": data, 'lalala': "lululu"});
      return documentReference.id;
    }
  }
  getData() {
  }
}