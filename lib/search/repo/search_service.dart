
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SearchService {
  static Future<List<EventModel>> getData()async
  {
    final responce = await _firestore
    .collection('events').get().then((value) => value.docs.map((e) {
      return EventModel.formjson(e.data());
    },).toList());
    
    return responce;
  }
  static Future<Object> getSearch(String text,List<EventModel> data)async
  {
    List<EventModel> result = [];
    for (var event in data) {
      if(event.title.contains(text.toUpperCase())||event.title.contains(text.toLowerCase())||event.category.contains(text.toUpperCase()))
      {
        result.add(event);
      }
    }
    return result;
  }
}