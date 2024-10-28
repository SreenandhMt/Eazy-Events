import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeService {
  static Future<Object> getTop10Event()async{
    final data = await _firestore.collection("events").limit(12).get().then((value) => value.docs.map((e) => EventModel.formjson(e.data())).toList());
    return data;
  }
}