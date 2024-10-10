import 'package:event_manager/event_list/repo/event_list_service.dart';
import 'package:flutter/material.dart';

import '../../home/models/event_model.dart';

class ListEventViewModel extends ChangeNotifier {
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

  getTypeEvent(String type)async
  {
    setLoading(true);
    final responce = await EventListService.getType(type);
    if(responce is List<EventModel>)
    {
      setEventModel(responce);
    }
    setLoading(false);
  }
  
  searchItem(String text)async
  {
    setLoading(true);
    final responce = await EventListService.getSearch(text);
    if(responce is List<EventModel>)
    {
      setEventModel(responce);
    }
    setLoading(false);
  }
}