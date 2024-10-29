import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/core/size.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:event_manager/utils/dark_check.dart';
import 'package:event_manager/utils/loading_screen.dart';

import '../view_models/dashboard_view_model.dart';

class EventOrders extends StatefulWidget {
  const EventOrders({super.key});

  @override
  State<EventOrders> createState() => _EventOrdersState();
}

class _EventOrdersState extends State<EventOrders> {


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    return ListView(
      children: [
        Padding(
           padding:screenSize.width<=1000? const EdgeInsets.only(left: 10,bottom: 10,top: 20):const EdgeInsets.only(left: 50,bottom: 10,top: 20),
           child: const Text("Select Event?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
         ),
         if(screenSize.width<=1000)
         LimitedBox(maxHeight: (70*(viewModel.myEvents.length+1.5)).toDouble(),child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            OrderEventsTable(events: viewModel.myEvents)
          ],
         ),)
         else
         OrderEventsTable(events: viewModel.myEvents)
      ],
    );
  }
}


class EventOrdersTickets extends StatefulWidget {
  const EventOrdersTickets({
    Key? key,
    required this.eventId,
  }) : super(key: key);
  final String eventId;

  @override
  State<EventOrdersTickets> createState() => _EventOrdersTicketsState();
}

class _EventOrdersTicketsState extends State<EventOrdersTickets> {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    if(viewModel.ticketModels==null||viewModel.ticketLoading)
      {
        if(viewModel.ticketModels==null)context.read<DashboardViewModel>().getOrders(widget.eventId);
        return const LoadingScreen();
      }
      if(viewModel.ticketModels!.isEmpty)
      {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Events",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.navigate_next_rounded),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        "Orders",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: isDarkTheme(context)
                        ? const Color.fromARGB(255, 102, 100, 100)
                        : const Color.fromARGB(255, 100, 100, 100),
                    child: const Icon(
                      Icons.info_outline_rounded,
                      size: 40,
                    ),
                  ),
                  height20,
                  Text(
                    "Event is Empty",
                    style: GoogleFonts.aBeeZee(fontSize: 30),
                  ),
                ]),
            const Spacer(),
          ],
        );
      }
    return ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () =>context.pop(),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Padding(
               padding: EdgeInsets.only(left: 50),
               child: Text("Events",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                       ),
                       Icon(Icons.navigate_next_rounded),
                       Padding(
               padding: EdgeInsets.only(left: 4),
               child: Text("Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                       ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Wrap(
              children: List.generate(viewModel.ticketModels!.length, (index) {
                return PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: const Text("Active"),onTap: () {
                        context.read<DashboardViewModel>().updateTicketStatus(true,viewModel.ticketModels![index].ticketID);
                      },),
                      PopupMenuItem(child: const Text("Claimed"),onTap: () {
                        context.read<DashboardViewModel>().updateTicketStatus(false,viewModel.ticketModels![index].ticketID);
                      },),
                    ];
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TicketData(username: viewModel.ticketModels![index].userName, email: viewModel.ticketModels![index].email, number: viewModel.ticketModels![index].userNumber, avalable: viewModel.ticketModels![index].active),
                  ),
                );
              },),
            ),
          )
        ],
      );
  }
}

class OrderEventsTable extends StatefulWidget {
  const OrderEventsTable({
    super.key,
    required this.events,
  });
  final List<EventModel> events;

  @override
  State<OrderEventsTable> createState() => OrderEventsTableState();
}

class OrderEventsTableState extends State<OrderEventsTable> {
  @override
  Widget build(BuildContext context) {
    return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              dividerTheme: const DividerThemeData(
                color: Colors.transparent,
                space: 0,
                thickness: 0,
                indent: 0,
                endIndent: 0,
              ),
            ),
            child: Container(
            margin: const EdgeInsets.only(left: 50,right: 50,bottom: 20,top: 10),
            padding: const EdgeInsets.all(10),
            decoration:BoxDecoration(
              color: AppColor.secondaryColor(context),
              borderRadius: BorderRadius.circular(7)
            ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Poster')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Category')),
                ],
                showCheckboxColumn: false,
                border: null,
                showBottomBorder: false,
                dividerThickness: 0.0,
                dataRowHeight: 70,
                rows: List.generate(
                  widget.events.length,
                  (index) => DataRow(onSelectChanged: (value) {
                    context.read<DashboardViewModel>().getOrders(widget.events[index].id);
                    context.go("/orders/tickets/${widget.events[index].id}");
                  },cells: [
                    DataCell(CachedNetworkImage(
                        imageUrl: widget.events[index].poster,
                        width: 60,
                        height: 50)),
                    DataCell(SizedBox(
                        width: 150,
                        child:
                            Text(widget.events[index].title, maxLines: 1))),
                    DataCell(
                      Text(widget.events[index].fee),
                    ),
                    DataCell(Text(widget.events[index].category)),
                  ]),
                ),
              ),
            ),
          );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    super.key,
    required this.username,
    required this.email,
    required this.number,
    required this.avalable
  });
  final String username;
  final String email;
  final String number;
  final bool avalable;

  @override
  Widget build(BuildContext context) {
    return TicketWidget(width: 300, height: 250,isCornerRounded: true,padding: const EdgeInsets.all(20), child: Column(
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
                  border: Border.all(width: 1.0, color: Colors.green),
                ),
                child: Center(
                  child: Text(
                    avalable?'Avalable':"Not Avalable",
                    style: TextStyle(color:avalable? Colors.green:Colors.red),
                  ),
                ),
              ),
              
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ticketDetailsWidget('Name', username, '', ''),
                ticketDetailsWidget('Gmail', email, '', ''),
                ticketDetailsWidget('Mobile Number', number, '', ''),
              ],
            ),
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