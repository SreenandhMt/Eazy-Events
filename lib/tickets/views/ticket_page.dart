import 'package:event_manager/utils/empty_screen_message.dart';
import 'package:event_manager/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'package:event_manager/tickets/models/user_ticket_model.dart';
import 'package:event_manager/tickets/view_model/ticket_view_model.dart';
import 'package:event_manager/utils/appbar.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({
    super.key,
    this.eventID,
  });
  final String? eventID;

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  void initState() {
    if(widget.eventID!=null)
    {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<TicketViewModel>().getEventTickets(widget.eventID!));
    }else{
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<TicketViewModel>().getMyTickets()); 
      
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TicketViewModel viewModel = context.watch<TicketViewModel>();
    if(viewModel.loading)
    {
      return const LoadingScreen();
    }
    return Scaffold(
      appBar: customAppBar(size,context),
      body:viewModel.ticketModel.isEmpty? const EmptyScreenMessage(text: "No Ticket Found", icon: Icons.close) : ListView(
        children: [
          Wrap(
            crossAxisAlignment: size.width<=900? WrapCrossAlignment.center:WrapCrossAlignment.start,
            alignment:size.width<=900? WrapAlignment.center: WrapAlignment.start,
            children:List.generate(viewModel.ticketModel.length, (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(onTap: (){},child: TicketData(ticketModel: viewModel.ticketModel[index])),
            ),),
          ),
        ],
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    super.key,
    required this.ticketModel,
  });
  final UserTicketModel ticketModel;

  @override
  Widget build(BuildContext context) {
    return TicketWidget(width: 300, height: 450,isCornerRounded: true,padding: const EdgeInsets.all(20), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 120.0,
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(width: 1.5, color: DateTime.parse(ticketModel.eventModel.date).millisecond<=DateTime.now().microsecond? Colors.green : Colors.red),
                ),
                child: Center(
                  child: Text(
                    DateTime.parse(ticketModel.eventModel.date).millisecond <= DateTime.now().microsecond?'Avalable':"Not Avalable",
                    style: TextStyle(color: DateTime.parse(ticketModel.eventModel.date).millisecond<=DateTime.now().microsecond? Colors.green : Colors.red),
                  ),
                ),
              ),
              
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Event Ticket',
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ticketDetailsWidget('Name', ticketModel.ticketModel.userName, '', ''),
                 Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                  child: eventDetailsWidget('Event', ticketModel.eventModel.title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                  child: ticketDetailsWidget('expaire',ticketModel.eventModel.date.split(" ").first,'', ""),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 13.0),
                  child: ticketDetailsWidget('Start Time', ticketModel.eventModel.startTime, 'End Time', ticketModel.eventModel.endTime),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 13.0),
            child: ticketDetailsWidget('Location', ticketModel.eventModel.location, '', ''),
          ),
          
        ],
      ),
    );
  }
}

Widget eventDetailsWidget(String firstTitle, String firstDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: SizedBox(
          width: 236,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: const TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ),
      
    ],
  );
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc, String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}