import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/event_details/repo/event_service.dart';
import 'package:event_manager/tickets/models/user_ticket_model.dart';

import '/dashboard/models/ticket_model.dart';
import '/dashboard/repo/dashboard_service.dart';
import '/event_details/models/user_model.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../home/models/event_model.dart';

final ImagePicker _picker = ImagePicker();
FirebaseStorage _storage = FirebaseStorage.instance;
List<String> eventType = [
    "Music",
    "Nightlife",
    "Art",
    "Dating",
    "Gaming",
    "Business",
    "Study",
    "Food and Drink",
    "Sports"
  ];

class DashboardViewModel extends ChangeNotifier{
  bool _loading = false;
  bool _ticketLoading = false;
  List<EventModel> _allEvents = [];
  // event filter
  List<EventModel> _myEvents = [];
  List<EventModel> _outOfStockEvents = [];
  List<EventModel> _expairedEvents = [];
  List<EventModel> _selectedEvents = [];

  EventModel? _editEvent;


  //category
  List<List<EventModel>> _categoryFilter = [];

  //event creating
  DateTime _selectedDate  = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  Uint8List? _filePath;
  XFile? _selectedFile;
  UserModel? _userModel;

  //ticket data
  List<TicketModel>? _ticketModels;

  bool get loading => _loading;
  bool get ticketLoading => _ticketLoading;

   List<EventModel> get allEvents => _allEvents;

  //event filter
  List<EventModel> get myEvents => _myEvents;
  List<EventModel> get outOfStockEvents => _outOfStockEvents;
  List<EventModel> get expairedEvents => _expairedEvents;
  List<EventModel> get selectedEvents => _selectedEvents;

  EventModel? get editEvent => _editEvent;

  //category
  List<List<EventModel>> get categoryFilter => _categoryFilter;

  //event creating
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;
  Uint8List? get filePath => _filePath;
  UserModel? get userModel => _userModel;

  //ticket data
  List<TicketModel>? get ticketModels => _ticketModels;

  setEventToEdit(EventModel? event)
  {
    _editEvent = event;
    notifyListeners();
  }

  setLoading(bool loading)async
  {
    _loading = loading;
    notifyListeners();
  }

  setTicketLoading(bool loading)async
  {
    _ticketLoading = loading;
    notifyListeners();
  }

  setMyEvents(List<EventModel> myEvents)
  {
    _myEvents = myEvents;
  }

  setDate(DateTime date){
    _selectedDate =date;
    notifyListeners();
  }
  setEndTime(TimeOfDay time){
    _endTime = time;
    notifyListeners();
  }

  setUserModel(UserModel userModel)
  {
    _userModel = userModel;
  }

  setTicketModel(List<TicketModel> ticketModels)
  {
    _ticketModels = ticketModels;
  }

  setStartTime(TimeOfDay time){
    _startTime = time;
    notifyListeners();
  }

  pickImage()async
  {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    
    if(file==null)
    {
      showMessage(ToastificationStyle.fillColored, ToastificationType.warning, "Failed to load image");
      return;
    }
    _selectedFile = file;
    _filePath = await file.readAsBytes();
    notifyListeners();
  }

  Future<String?> getLink()async
  {
    if(_filePath==null)
    {
      showMessage(ToastificationStyle.fillColored, ToastificationType.warning, "Image is required");
      return null;
    }
    return await _storage.ref("posters/").child("${DateTime.now().microsecondsSinceEpoch.toString()}.${_selectedFile!.mimeType!.split("/").last}").putData(_filePath!,SettableMetadata(contentType: _selectedFile!.mimeType!)).then((p0) => p0.ref.getDownloadURL());
  }
  showOutOfStockEvents()
  {
    _selectedEvents = _outOfStockEvents;
    notifyListeners();
  }
  showAllEvents()
  {
    _selectedEvents  = _myEvents;
    notifyListeners();
  }
  showExpairedEvents()
  {
    _selectedEvents = _expairedEvents;
    notifyListeners();
  }

  getOrders(String eventID)async
  {
    setTicketLoading(true);
    final responce = await DashboardService.getEventTickets(eventID);
    if(responce is List<TicketModel>)
    {
      setTicketModel(responce);
    }
    setTicketLoading(false);
  }

  getMyEvents()async{
    setLoading(true);
    final responce = await DashboardService.getMyEvents();
    if(responce is List<EventModel>)
    {
      _allEvents = responce;
      filterEvents(responce);
    }
    final profileResponce = await DashboardService.getUser();
    if(profileResponce is UserModel)
    {
      setUserModel(profileResponce);
    }
    setLoading(false);
  }

  deleteEvent(EventModel event)async
  {
    setLoading(true);
    DashboardService.deleteEvent(event.id);
    _allEvents.remove(event);
    await filterEvents(_allEvents);
    setLoading(false);
  }

  createEvent({required Map<String,dynamic> event})async
  {
    setLoading(true);
    DashboardService.createEvents(event);
    setLoading(false);
  }

  updateEvent({required Map<String,dynamic> event})
  {
    setLoading(true);
    DashboardService.updateEvents(event);
    setLoading(false);
  }

  filterEvents(List<EventModel> responce)async
  {
    List<EventModel> outofStock = [],expaired = [],allEvents = [];
    // filter the category
      Map<String, List<EventModel>> groupedByCategory = {};
      for (var event in responce) {
        groupedByCategory.putIfAbsent(event.category, () => []).add(event);
      }
      _categoryFilter = groupedByCategory.values.toList();
      
      // filter the out of stock and expaired event
      for (var event in responce) {
        
        allEvents.add(event);
        if(DateTime.parse(event.date).microsecondsSinceEpoch < DateTime.now().microsecondsSinceEpoch)
        {
          expaired.add(event);
          allEvents.remove(event);
        }
        else if (event.stock == "0") {
          outofStock.add(event);
        }
      }
      _expairedEvents = expaired;
      _outOfStockEvents = outofStock;
      _selectedEvents = allEvents;
      setMyEvents(allEvents);
  }

  updateTicketStatus(bool status,String id)async
  {
    await FirebaseFirestore.instance.collection('Tickets').doc(id).update({
      "active":status
    });
  }

  showMessage(ToastificationStyle style,ToastificationType type,String text)
  {
    toastification.show(
        title: Text(text),
        style: style,
        type: type,
        autoCloseDuration: const Duration(seconds: 4),
        animationDuration: const Duration(milliseconds: 200),
      );
  }
}