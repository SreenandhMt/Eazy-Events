import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:event_manager/components/dashboard/event_widget.dart';
import 'package:event_manager/core/colors.dart';
import 'package:event_manager/core/size.dart';
import 'package:event_manager/dashboard/view_models/dashboard_view_model.dart';
import 'package:event_manager/dashboard/views/event_creating.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:event_manager/utils/appbar.dart';

import '../../event_details/view_models/event_view_model.dart';
import '../../utils/navigation_utils.dart';

String? selectedDate;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      body: ListView(
        children: [
          customAppBar(screenSize,context),
          height30,
          if(viewModel.userModel!=null)
          Row(
            children: [
              width10,
              const CircleAvatar(radius: 40,child: Icon(Icons.account_circle),),
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel.userModel!.name,style: GoogleFonts.aBeeZee(fontSize: 30,fontWeight: FontWeight.w800),),
                  Row(
                    children: [
                  const Icon(Icons.circle,size: 4,),
                  width5,
                  Text("${viewModel.userModel!.followers.length} Following"),
                    ],
                  )
                ],
              ),
              width10,
              const Icon(Icons.edit_note_rounded)
            ],
          ),
          height20,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Your event history",style: GoogleFonts.aBeeZee(fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              IconButton(onPressed: () => showDialog(context: context,builder: (context) => Dialog(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),child: const EventCreatingPage()),),icon: const Icon(Icons.add_box_outlined))
            ],
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.8/1.5,
                crossAxisCount: screenSize.width<=600?1:screenSize.width<=870?2:screenSize.width<=1000? 3:4),
            itemCount: viewModel.myEvents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: DashboardEventWidget(myEvents: viewModel.myEvents[index],onTap: (){
                  showDialog(context: context,builder: (context) => Dialog(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),child: DashboardScreen(eventModel: viewModel.myEvents[index],)),);
                   },),
              );
            },
          ),
        ],
      ),
    );
  }
}


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.eventModel,
  });
  final EventModel eventModel;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 550,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Details'),
          actions: [IconButton(onPressed: (){context.read<EventViewModel>().setEventData(widget.eventModel);
                   AppNavigation.eventDetailsPage(context,widget.eventModel.id);}, icon: Icon(Icons.open_in_full_rounded))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCard('Tickets Sold', 'Exist Stock ${widget.eventModel.stock}'),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Share',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'https://www.eventbrite.com/e/ddddd-tickets-10393859..',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      // Logic to copy the link
                    },
                  ),
                  IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        Share.share('check out my website https://example.com');
                      },
                    ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Edit',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              height10,
              MaterialButton(color: AppColor.primaryColor,padding: EdgeInsets.all(15),child: Center(child: Text("Edit Event")),onPressed: ()=>showDialog(context: context,builder: (context) => Dialog(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),child: EventCreatingPage(eventModel: widget.eventModel)),)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return GestureDetector(
      onTap: (){
        AppNavigation.showEventTickets(context, widget.eventModel.id);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.primaryColor,width: 2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(fontSize: 20)
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
