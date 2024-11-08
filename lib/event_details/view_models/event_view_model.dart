import 'package:event_manager/event_details/models/user_model.dart';
import 'package:event_manager/event_details/repo/event_service.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class EventViewModel extends ChangeNotifier{
  bool _loading = false;
  // bool _profileLoading = false;
  EventModel? _eventModel;
  UserModel? _userModel;
  bool _userFollowed = false;

  bool get loading => _loading;
  // bool get profileLoading => _profileLoading;
  bool get userFollowed => _userFollowed;
  EventModel? get eventModel => _eventModel;
  UserModel? get userModel => _userModel;

  setEventData(EventModel eventModel)
  {
    _eventModel = eventModel;
    getUser(eventModel.createrid);
    checkUserFollow(eventModel.createrid);
  }

  setUserModel(UserModel userModel){
    _userModel = userModel;
  }

  setLoading(bool loading)async
  {
    _loading = loading;
    notifyListeners();
  }

  setFollowStatus(bool status)
  {
    _userFollowed = status;
    notifyListeners();
  }

  checkUserFollow(String createrid)async
  {
    final responce = await EventService.isUserFollowedByChannel(createrid);
    setFollowStatus(responce);
  }

  getUser(String createrid)async
  {
    setLoading(true);
    checkUserFollow(createrid);
    final profileResponce = await EventService.getUser(createrid);
    if (profileResponce is UserModel) {
      setUserModel(profileResponce);
    }
    if (profileResponce is String) {
      showMessage(ToastificationStyle.fillColored, ToastificationType.error,
          profileResponce);
    }
    setLoading(false);
  }

  follow(String createrid)async
  {
    final responce = await EventService.followUser(createrid);
    if(responce is String)
    {
      showMessage(ToastificationStyle.fillColored, ToastificationType.error, responce);
    }
    _userModel!.followers.add(FirebaseAuth.instance.currentUser!.uid);
    checkUserFollow(createrid);
  }
  unfollow(String createrid)async
  {
    final responce = await EventService.unfollowUser(createrid);
    if(responce is String)
    {
      showMessage(ToastificationStyle.fillColored, ToastificationType.error, responce);
    }
    _userModel!.followers.remove(FirebaseAuth.instance.currentUser!.uid);
    checkUserFollow(createrid);
  }

  reLoadData(String id)async
  {
    setLoading(true);
    final responce = await EventService.getEvent(id);
    if(responce is EventModel)
    {
      setEventData(responce);
    }
    if(responce is String)
    {
      showMessage(ToastificationStyle.fillColored, ToastificationType.error, responce);
    }
    setLoading(false);
  }

  createTicket({required String eventID,required String stock,required String createrID,required String phoneNumber,required String name})async{
    final user = FirebaseAuth.instance.currentUser;
    if(user==null) return showMessage(ToastificationStyle.fillColored, ToastificationType.error, "You are not logged");
    setLoading(true);
    await EventService.createTicket(eventID: eventID,phoneNumber: phoneNumber,name: name,createrID: createrID,stock: stock);
    user.updateDisplayName(name);
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