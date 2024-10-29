import 'package:event_manager/home/models/event_model.dart';
import 'package:event_manager/home/repo/home_service.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel extends ChangeNotifier {

  bool _loading = false;
  List<EventModel>? _eventModels;

  bool get loading => _loading;
  List<EventModel>? get eventModels => _eventModels;

  setLoading(bool loading)async{
    _loading = loading;
    notifyListeners();
  }

  setEventModel(List<EventModel>? eventModels)
  {
    _eventModels = eventModels;
  }

  getTop10Event()async{
    setLoading(true);
    final responce = await HomeService.getTopRandomEvents();
    // if(responce is List<EventModel>)
    // {
      setEventModel(responce);
    // }
    setLoading(false);
  }
}