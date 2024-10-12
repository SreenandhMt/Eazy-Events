import 'package:event_manager/search/repo/search_service.dart';
import 'package:flutter/material.dart';

import '../../home/models/event_model.dart';

class SearchViewModel extends ChangeNotifier {
  List<EventModel> _eventList = [];
  bool _loading = false;

  List<EventModel> get eventList => _eventList;
  bool get loading => _loading;

  setLoading(bool loading)async
  {
    _loading = loading;
    notifyListeners();
  }

  setEventModel(List<EventModel> eventList)
  {
    _eventList = eventList;
  }
  
  searchItem(String text)async
  {
    setLoading(true);
    final responce = await SearchService.getSearch(text);
    if(responce is List<EventModel>)
    {
      setEventModel(responce);
    }
    setLoading(false);
  }
}