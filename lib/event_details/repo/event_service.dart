import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/event_details/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/models/event_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class EventService {
  static Future<Object> getEvent(String id)async
  {
    try {
      return await _firestore.collection("events").doc(id).get().then((value) => EventModel.formjson(value.data()!));
    }on FirebaseException catch(e){
      return e.message!;
    }
     catch (e) {
      return e.toString();
    }
  }

  static Future<Object> getUser(String uid)async{
    try {
      return _firestore.collection("profile").doc(uid).get().then((event) => UserModel.formjson(event.data()!));
    } on FirebaseException catch(e){
      return e.message!;
    }
     catch (e) {
      return e.toString();
    }
  }

  static Future<Object> followUser(String followUserId) async {
    try {
      User? currentUser = _auth.currentUser;
    if(currentUser == null) return "You are not Logined";
    final String currentUserId = currentUser.uid;
    await _firestore.collection('profile').doc(currentUserId).update({
      'following': FieldValue.arrayUnion([followUserId])
    });

    await _firestore.collection('profile').doc(followUserId).update({
      'followers': FieldValue.arrayUnion([currentUserId])
    });
    return true;
    }on FirebaseException catch(e){
      return e.message!;
    }
     catch (e) {
      return e.toString();
    }
  }

  static Future<Object> unfollowUser(String unfollowUserId) async {
    try {
      User? currentUser = _auth.currentUser;
    if(currentUser == null) return "You are not Logined";
    await _firestore.collection('profile').doc(currentUser.uid).update({
      'following': FieldValue.arrayRemove([unfollowUserId])
    });

    await _firestore.collection('profile').doc(unfollowUserId).update({
      'followers': FieldValue.arrayRemove([currentUser.uid])
    });
    return true;
    } on FirebaseException catch(e){
      return e.message!;
    }
     catch (e) {
      return e.toString();
    }
  }

  static Future<bool> isUserFollowedByChannel(String createrid) async {
  User? currentUser = _auth.currentUser;
  if (currentUser != null) {
    DocumentSnapshot channelDoc = await FirebaseFirestore.instance
        .collection('profile')
        .doc(createrid)
        .get();

    if (channelDoc.exists) {
      List<dynamic> followers = channelDoc['followers'];
      return followers.contains(currentUser.uid);
    }
  }
  return false;
}

  static Future<Object> createTicket({required String eventID,required String stock,required String createrID,required String phoneNumber,required String name})async{
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    await _firestore.collection('events').doc(eventID).update({
      "stock":(int.parse(stock)-1).toString()
    });
    await _firestore.collection('Tickets').doc(id).set({
      "userName":name,
      "userEmail":_auth.currentUser!.email??"",
      "contactNumber":phoneNumber,
      "userPhoto":_auth.currentUser!.photoURL??"",
      "uid":_auth.currentUser!.uid,
      "ticketID":id,
      "createrID":createrID,
      "eventID":eventID,
      "active":true
    });
    return "success";
  } 

}