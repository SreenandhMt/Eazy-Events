import 'package:event_manager/tickets/models/user_ticket_model.dart';
import 'package:event_manager/tickets/repo/ticket_service.dart';
import 'package:flutter/material.dart';

class TicketViewModel extends ChangeNotifier {
  // TicketViewModel()
  // {
  //   getMyTickets();
  // }

  List<UserTicketModel> _ticketModel = [];
  bool _loading = false;

  List<UserTicketModel> get ticketModel => _ticketModel;
  bool get loading => _loading;

  setTicket(List<UserTicketModel> ticketModel)
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

  getEventTickets(String eventID)async
  {
    setLoading(true);
    final reponce = await TicketService.getEventTickets(eventID);
    if(reponce is List<UserTicketModel>)
    {
      setTicket(reponce);
    }
    setLoading(false);
  }

  getMyTickets()async
  {
    setLoading(true);
    final reponce = await TicketService.getMyTickets();
    if(reponce is List<UserTicketModel>)
    {
      setTicket(reponce);
    }
    setLoading(false);
  }
}