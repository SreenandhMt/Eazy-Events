
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/dashboard/models/ticket_model.dart';
import 'package:event_manager/dashboard/repo/dashboard_service.dart';
import 'package:event_manager/event_details/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../home/models/event_model.dart';

final ImagePicker _picker = ImagePicker();
FirebaseStorage _storage = FirebaseStorage.instance;

class DashboardViewModel extends ChangeNotifier{
  DashboardViewModel(){
    getMyEvents();
  }
  bool _loading = false;
  List<EventModel> _myEvents = [];
  DateTime _selectedDate  = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  Uint8List? _filePath;
  XFile? _selectedFile;
  UserModel? _userModel;
  List<TicketModel>? _ticketModels;

  bool get loading => _loading;
  List<EventModel> get myEvents => _myEvents;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;
  Uint8List? get filePath => _filePath;
  UserModel? get userModel => _userModel;
  List<TicketModel>? get ticketModels => _ticketModels;

  setLoading(bool loading)async
  {
    _loading = loading;
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

  getMyEvents()async{
    setLoading(true);
    final responce = await DashboardService.getMyEvents();
    if(responce is List<EventModel>)
    {
      setMyEvents(responce);
    }
    final profileResponce = await DashboardService.getUser();
    if(profileResponce is UserModel)
    {
      setUserModel(profileResponce);
    }
    final ticketResponce = await DashboardService.getTickets();
    if(ticketResponce is List<TicketModel>)
    {
      setTicketModel(ticketResponce);
    }
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