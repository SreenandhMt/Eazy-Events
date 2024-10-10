import 'package:event_manager/dashboard/models/ticket_model.dart';
import 'package:event_manager/home/models/event_model.dart';

class UserTicketModel {
  final TicketModel ticketModel;
  final EventModel eventModel;

  UserTicketModel({required this.ticketModel, required this.eventModel});
}