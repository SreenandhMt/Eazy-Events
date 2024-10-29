import 'package:event_manager/components/event_details/event_details_desktop_view.dart';
import 'package:event_manager/components/event_details/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../core/size.dart';
import '../../event_details/view_models/event_view_model.dart';

TextStyle textStyleFredoka({double? fontSize,FontWeight? fontWeight,Color? color}){
  return GoogleFonts.fredoka(fontSize: fontSize,fontWeight: fontWeight,color: color);
}

class EventDetailsMobileView extends StatefulWidget {
  const EventDetailsMobileView({
    super.key
  });

  @override
  State<EventDetailsMobileView> createState() => _EventDetailsMobileViewState();
}

class _EventDetailsMobileViewState extends State<EventDetailsMobileView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    EventViewModel eventViewModel = context.watch<EventViewModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height20,
              Text(
                DateFormat.yMMMMd('en_US')
                    .format(DateTime.parse(eventViewModel.eventModel!.date)),
                style: textStyleFredoka(
                    fontSize: 13, fontWeight: FontWeight.w600),
                maxLines: 1,
              ),
              Text(
                eventViewModel.eventModel!.title,
                style: textStyleFredoka(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
              height10,
              Text(
                eventViewModel.eventModel!.subtitle,
                style: textStyleFredoka(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              height25,
              //profile
              ProfileWidget(userModel: eventViewModel.userModel!, createrID: eventViewModel.eventModel!.createrid, isFollowed: eventViewModel.userFollowed),
              //title
              Text("Date and time",
                  style: textStyleFredoka(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              height10,
              DateAndTimeWidget(eventModel: eventViewModel.eventModel!,width: screenSize.width*0.9,),
             height10,
              //title
              Text("Location",
                  style: textStyleFredoka(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              Text(
                "Online",
                style: textStyleFredoka(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              //title
             height10,
                    Text("About event",
                        style: textStyleFredoka(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    height20,
                    TextParser(text: eventViewModel.eventModel!.about),
                    // registration details
                    if(eventViewModel.eventModel!.registrationDetails!=null&&eventViewModel.eventModel!.registrationDetails!.isNotEmpty)
                    ...[
                      height10,
                    Text("Regisraction details",
                        style: textStyleFredoka(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    height20,
                    Text(eventViewModel.eventModel!.registrationDetails!),
                    ],
            ],
          ),
          height35,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            child: const Center(child: Text("© 2024 EazyEvent")),
          ),
        ],
      ),
    );
  }
}
