
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
  static Future<List<EventModel>> getSearch(String text, List<EventModel> data) async {
    List<EventModel> result = [];

    if (text.isEmpty) return data;

    final searchText = text.toLowerCase();
    for (var event in data) {
      if (event.title.toLowerCase().contains(searchText) ||
          event.category.toLowerCase().contains(searchText)||event.createrName.toLowerCase().contains(searchText)||event.date.toLowerCase().contains(searchText)||event.fee.toLowerCase().contains(searchText)) {
        result.add(event);
      }
    }

    return result;
  }
}