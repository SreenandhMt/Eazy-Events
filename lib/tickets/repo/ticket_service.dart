
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:event_manager/tickets/models/user_ticket_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../dashboard/models/ticket_model.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class TicketService {
  static Future<List<List<UserTicketModel>>> getMyTickets() async {
    List<List<UserTicketModel>> groupedUserTicketModels = [];

    try {
      // Fetch all tickets for the current user
      final ticketList = await _firestore
          .collection("Tickets")
          .where("uid", isEqualTo: _auth.currentUser!.uid)
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => TicketModel.formjson(doc.data()))
              .toList());

      // Group tickets by event ID
      final Map<String, List<TicketModel>> ticketsByEventId = {};
      for (var ticket in ticketList) {
        ticketsByEventId.putIfAbsent(ticket.eventID, () => []).add(ticket);
      }

      // Fetch unique events based on grouped event IDs
      final eventIds = ticketsByEventId.keys.toList();
      final eventSnapshots = await _firestore
          .collection("events")
          .where(FieldPath.documentId, whereIn: eventIds)
          .get();

      // Map events by their IDs for easy lookup
      final eventMap = {
        for (var doc in eventSnapshots.docs)
          doc.id: EventModel.formjson(doc.data()),
      };

      // Construct the grouped list of lists
      for (var eventId in ticketsByEventId.keys) {
        final event = eventMap[eventId];
        if (event != null) {
          final userTicketsForEvent = ticketsByEventId[eventId]!.map((ticket) {
            return UserTicketModel(ticketModel: ticket, eventModel: event);
          }).toList();
          groupedUserTicketModels.add(
              userTicketsForEvent); // Each sublist corresponds to tickets for one event
        }
      }
    } catch (e) {
      // Error handling if needed
      print("Error fetching grouped tickets: $e");
    }

    return groupedUserTicketModels;
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