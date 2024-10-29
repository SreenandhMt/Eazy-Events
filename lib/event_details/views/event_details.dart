import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/components/event_details/event_details_desktop_view.dart';
import 'package:event_manager/components/event_details/event_details_mobile_view.dart';
import 'package:event_manager/components/event_details/register_button.dart';
import 'package:event_manager/components/event_details/ticket_register.dart';
import 'package:event_manager/utils/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/utils/appbar.dart';
import 'package:toastification/toastification.dart';

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

    // checking event data and loading
    final responce = checkDataStatus(eventViewModel);
    if(responce is Widget)return responce;

    //main page
    return Scaffold(
      //mobile appbar
      appBar: screenSize.width<=1000?customAppBar(screenSize,context):null,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // desktop appbar
                if(screenSize.width>=1000)
                customAppBar(screenSize,context),
                //banner
                CachedNetworkImage(imageUrl: eventViewModel.eventModel!.poster,imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10,left:screenSize.width>=1000? 100:10,right:screenSize.width>=1000? 100:10),
                  height:screenSize.width>=1000? 450:250,
                  decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                  image:DecorationImage(image: imageProvider,fit: BoxFit.cover)
                ),),),
                // main widgets
                if(screenSize.width>=1000)
                const EventDetailsDesktopView()
                else
                const EventDetailsMobileView()
              ],
            ),
          ),
          //mobile registraction button
          if(screenSize.width<=1000&&eventViewModel.eventModel!=null)
          RegisterButton(eventModel: eventViewModel.eventModel!)
        ],
      ),
    );
  }

  Widget? checkDataStatus(eventViewModel)
  {
    if(eventViewModel.loading)
    {
      return const LoadingScreen();
    }
    if(eventViewModel.eventModel==null)
    {
      WidgetsBinding.instance.addPostFrameCallback((_) =>context.read<EventViewModel>().reLoadData(widget.eventID));
      
      return const LoadingScreen();
    }
    if(eventViewModel.userModel==null)
    {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>context.read<EventViewModel>().getUser(eventViewModel.eventModel!.createrid));
      return const LoadingScreen();
    }
    return null;
  }
}