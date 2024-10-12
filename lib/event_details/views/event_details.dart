import 'package:event_manager/components/event_details/event_details_desktop_view.dart';
import 'package:event_manager/components/event_details/event_details_mobile_view.dart';
import 'package:event_manager/components/event_details/ticket_register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/utils/appbar.dart';

import '../view_models/event_view_model.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    super.key,
    required this.eventID,
  });
  final String eventID;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final _key = GlobalKey();
  double columnHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getColumnHeight();
    });
  }

  void _getColumnHeight() {
    final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        columnHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    EventViewModel eventViewModel = context.watch<EventViewModel>();
    if(eventViewModel.loading)
    {
      return const Center(child: CircularProgressIndicator());
    }
    if(eventViewModel.eventModel==null)
    {
      context.read<EventViewModel>().reLoadData(widget.eventID);
      return const SizedBox();
    }
    if(eventViewModel.userModel==null)
    {
       WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>context.read<EventViewModel>().getUser(eventViewModel.eventModel!.createrid));
      return const Center(child: CircularProgressIndicator(color: Colors.red,));
    }
    return Scaffold(
      appBar: screenSize.width<=1000?AppBar():null,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if(screenSize.width>=1000)
                customAppBar(screenSize,context),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,height: 400,decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(9),
                  image:eventViewModel.eventModel!.poster.isEmpty?null: DecorationImage(image: NetworkImage(eventViewModel.eventModel!.poster),fit: BoxFit.cover)
                ),),
                if(screenSize.width>=1000)
                const EventDetailsDesktopView()
                else
                const EventDetailsMobileView()
              ],
            ),
          ),
          if(screenSize.width<=1000)
          Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(color: AppColor.secondaryColor(context),borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(int.parse(eventViewModel.eventModel!.stock)<=0?"No Stock":eventViewModel.eventModel!.fee=="0"?"Free":"Rs.${eventViewModel.eventModel!.fee}",style: GoogleFonts.fredoka(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(onPressed: (){
                    if(int.parse(eventViewModel.eventModel!.stock)<=0)return;
                    showDialog(context: context, builder: (context) => Dialog(child: CheckoutPage(eventModel: eventViewModel.eventModel!),),);
                  },minWidth: double.infinity,height: 50,padding: const EdgeInsets.all(10),color: AppColor.primaryColor,child: Text("Get Ticket",style: GoogleFonts.aBeeZee(),),),
                )
              ],
            ),
          ),
        )
        ],
      ),
    );
  }
}