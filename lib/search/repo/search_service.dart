
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SearchService {
  static Future<Object> getSearch(String text)async
  {
    List<EventModel> data = [];
    final responce = await _firestore
    .collection('events').get().then((value) => value.docs.map((e) {
      return EventModel.formjson(e.data());
    },).toList());
    for (var event in responce) {
      if(event.title.contains(text.toLowerCase())||event.title.contains(text.toUpperCase()))
      {
        data.add(event);
      }
    }
    return data;
  }
}