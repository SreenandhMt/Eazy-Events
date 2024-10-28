import 'package:event_manager/category_list/repo/category_service.dart';
import 'package:flutter/material.dart';

import '../../home/models/event_model.dart';

class CategoryViewModels extends ChangeNotifier {
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
    final responce = await CategoryService.getType(type);
    if(responce is List<EventModel>)
    {
      setEventModel(responce);
    }
    setLoading(false);
  }
  
}