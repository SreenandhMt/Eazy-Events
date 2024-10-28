import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/dashboard/models/ticket_model.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../event_details/models/user_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class DashboardService {
  static Future<Object> addEvent(Map<String, dynamic> map)async{
   try {
     await _firestore.collection("events").doc(map['id']).set(map);
     return "success";
   } catch (e) {
     return e.toString();
   }
  }

  static Future<Object> getMyEvents()async
  {
    try {
      final responce = await _firestore.collection("events").where("createrid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) => value.docs.map((e) => EventModel.formjson(e.data()),).toList());
      return responce;
    } catch (e) {
      return e.toString();
    }
  }

   static Future<Object> getEventTickets(String eventID)async
  {
    List<TicketModel> ticketModel = [];
     ticketModel = await _firestore.collection("Tickets").where("eventID",isEqualTo: eventID).get().then((event) => event.docs.map((e) => TicketModel.formjson(e.data()),).toList());
    
     return ticketModel;
  }

  static Future<Object> createEvents(Map<String,dynamic> event)async
  {
    try {
      await _firestore.collection("events").doc(event["id"]).set(event);
      return "success";
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  static Future<Object> getUser()async{
    try {
      return _firestore.collection("profile").doc(_auth.currentUser!.uid).get().then((event) => UserModel.formjson(event.data()!));
    } on FirebaseException catch(e){
      return e.message!;
    }
     catch (e) {
      return e.toString();
    }
  }

  static Future<Object> getTickets()async{
    try {
      return _firestore.collection("Tickets").where("createrID",isEqualTo: _auth.currentUser!.uid).get().then((event) => event.docs.map((e) => TicketModel.formjson(e.data()),).toList());
    } on FirebaseException catch(e){
      return e.message!;
    }
     catch (e) {
      return e.toString();
    }
  }

  static Future<Object> updateEvents(Map<String,dynamic> event)async
  {
    try {
      await _firestore.collection("events").doc(event["id"]).update(event);
      return "success";
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }
  
}