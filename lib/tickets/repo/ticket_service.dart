import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:event_manager/tickets/models/user_ticket_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../dashboard/models/ticket_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class TicketService {
  static Future<Object> getMyTickets()async
  {
    List<UserTicketModel> userTicketModel = [];
     final ticketList = await _firestore.collection("Tickets").where("uid",isEqualTo: _auth.currentUser!.uid).get().then((event) => event.docs.map((e) => TicketModel.formjson(e.data()),).toList());
     for (var ticket in ticketList) {
       final event = await _firestore.collection("events").doc(ticket.eventID).get().then((event) => EventModel.formjson(event.data()!));
        userTicketModel.add(UserTicketModel(ticketModel: ticket, eventModel: event));
     }
     return userTicketModel;
  }

  static Future<Object> getEventTickets(String eventID)async
  {
    List<UserTicketModel> userTicketModel = [];
     final ticketList = await _firestore.collection("Tickets").where("eventID",isEqualTo: eventID).get().then((event) => event.docs.map((e) => TicketModel.formjson(e.data()),).toList());
     for (var ticket in ticketList) {
       final event = await _firestore.collection("events").doc(ticket.eventID).get().then((event) => EventModel.formjson(event.data()!));
       if(event.createrid!=_auth.currentUser!.uid)return [];
       userTicketModel.add(UserTicketModel(ticketModel: ticket, eventModel: event));
     }
     return userTicketModel;
  }
}