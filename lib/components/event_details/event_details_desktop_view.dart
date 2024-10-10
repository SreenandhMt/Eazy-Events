import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/components/event_details/register_button.dart';
import 'package:event_manager/event_details/models/user_model.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/home/models/event_model.dart';

import '../../core/colors.dart';
import '../../core/size.dart';

class EventDetailsDesktopView extends StatefulWidget {
  const EventDetailsDesktopView({
    Key? key,
  }) : super(key: key);

  @override
  State<EventDetailsDesktopView> createState() =>
      _EventDetailsDesktopViewState();
}

class _EventDetailsDesktopViewState extends State<EventDetailsDesktopView> {
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
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LimitedBox(
              maxWidth: (screenSize.width / 2),
              child: Column(
                key: _key,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height20,
                  Text(
                    DateFormat.yMMMMd('en_US')
                        .format(DateTime.parse(eventViewModel.eventModel!.date)),
                    style: GoogleFonts.fredoka(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    eventViewModel.eventModel!.title,
                    style: GoogleFonts.fredoka(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  height10,
                  Text(
                    eventViewModel.eventModel!.subtitle,
                    style: GoogleFonts.fredoka(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  height25,
                  //profile
                  Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 20, top: 10, bottom: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor(context),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(eventViewModel.userModel!.profilePhoto),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(eventViewModel.userModel!.name,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 19),),
                                Text("Followers ${eventViewModel.userModel!.followers.length.toString()}"),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            if (FirebaseAuth.instance.currentUser!=null&&eventViewModel.userModel!.uid!=FirebaseAuth.instance.currentUser!.uid)
                              MaterialButton(
                                onPressed: () {
                                  if(eventViewModel.userFollowed)return context.read<EventViewModel>().unfollow(eventViewModel.eventModel!.createrid);
                                  context.read<EventViewModel>().follow(eventViewModel.eventModel!.createrid);
                                },
                                color: Colors.blue,
                                padding: const EdgeInsets.all(20),
                                child: Text(eventViewModel.userFollowed?"Unfollow":"Follow"),
                              )
                          ],
                        ),
                      ),
                  //title
                  Text("Date and time",
                      style: GoogleFonts.fredoka(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColor.tertiaryColor(context),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(DateFormat('MMMM', "en_US")
                            .format(DateTime.parse(eventViewModel.eventModel!.date))),
                        CircleAvatar(
                            child: Text(DateTime.parse(eventViewModel.eventModel!.date)
                                .day
                                .toString())),
                        Text(eventViewModel.eventModel!.startTime),
                      ],
                    ),
                  ),
                  //title
                  Text("Location",
                      style: GoogleFonts.fredoka(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(
                    "Online",
                    style: GoogleFonts.fredoka(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  //title
                  height10,
                  Text("About event",
                      style: GoogleFonts.fredoka(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  height20,
                  Text(eventViewModel.eventModel!.about),
                ],
              ),
            ),
            LimitedBox(
              maxWidth: (screenSize.width / 2) * 0.4,
              child: RegisterButton(
                height: columnHeight != 0 ? columnHeight : 500,
                fee: eventViewModel.eventModel!.fee,
                eventID: eventViewModel.eventModel!.id,
                createrID: eventViewModel.eventModel!.createrid,
                stock:eventViewModel.eventModel!.stock,
              ),
            )
          ],
        ),
        height35,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: const Center(child: Text("© 2024 EazyEvent")),
        ),
      ],
    );
  }
}
