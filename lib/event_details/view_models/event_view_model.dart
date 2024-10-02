import 'package:event_manager/home/models/event_model.dart';
import 'package:flutter/material.dart';

class EventViewModel extends ChangeNotifier{
  bool _loading = false;
  bool _profileLoading = false;
  EventModel? _eventModel;

  bool get loading => _loading;
  bool get profileLoading => _profileLoading;
  EventModel? get eventModel => _eventModel;

  setEventData(EventModel eventModel)
  {
    _eventModel = eventModel;
  }
}