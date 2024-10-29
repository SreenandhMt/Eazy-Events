import 'package:event_manager/tickets/models/user_ticket_model.dart';
import 'package:event_manager/tickets/repo/ticket_service.dart';
import 'package:flutter/material.dart';

class TicketViewModel extends ChangeNotifier {

  List<List<UserTicketModel>> _ticketModel = [];
  bool _loading = false;

  List<List<UserTicketModel>> get ticketModel => _ticketModel;
  bool get loading => _loading;

  setTicket(List<List<UserTicketModel>> ticketModel)
  {
    _ticketModel = ticketModel;
  }

  setLoading(bool loading)async{
    _loading = loading;
    notifyListeners();
  }

  clearData()
  {
    setLoading(true);
    setTicket([]);
    setLoading(false);
  }


  getMyTickets()async
  {
    setLoading(true);
    final reponce = await TicketService.getMyTickets();
    setTicket(reponce);
    setLoading(false);
  }
}