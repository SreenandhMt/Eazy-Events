import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeService {
 static Future<List<EventModel>> getTopRandomEvents() async {
  final querySnapshot = await _firestore.collection("events").get();
  List<EventModel> events = querySnapshot.docs.map((doc) => EventModel.formjson(doc.data())).toList();
  events.shuffle(Random());
  return events.take(12).toList();
}
}