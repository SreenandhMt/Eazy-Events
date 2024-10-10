
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class EventListService {
  static Future<Object> getList(String createrID)async
  {
    final responce = await _firestore.collection("events").where("createrid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) => value.docs.map((e) => EventModel.formjson(e.data()),).toList());
    return responce;
  }
  static Future<Object> getType(String type)async
  {
    final responce = await _firestore.collection("events").where("category",isEqualTo: type).get().then((value) => value.docs.map((e) => EventModel.formjson(e.data()),).toList());
    return responce;
  }
  static Future<Object> getSearch(String text)async
  {
    final responce = await _firestore
    .collection('events').get().then((value) => value.docs.map((e) {
      return e.data();
    },).toList());
    return responce;
  }
}