
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CategoryService {
  static Future<Object> getType(String type)async
  {
    final responce = await _firestore.collection("events").where("category",isEqualTo: type).get().then((value) => value.docs.map((e) => EventModel.formjson(e.data()),).toList());
    return responce;
  }
}