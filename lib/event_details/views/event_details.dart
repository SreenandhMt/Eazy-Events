import 'package:event_manager/core/size.dart';
import 'package:event_manager/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../view_models/event_view_model.dart';

final _key = GlobalKey();

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
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
    
    if(eventViewModel.eventModel==null)
    {
      return SizedBox();//TODO set loading
    }
    return Scaffold(
      body: ListView(
        children: [
          customAppBar(),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,height: 400,decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(9),
            image: DecorationImage(image: NetworkImage(eventViewModel.eventModel!.poster.first),fit: BoxFit.cover)
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LimitedBox(
                maxWidth: (screenSize.width/2),
                // maxHeight: screenSize.width*0.5,
                child: Column(
                  key: _key,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height20,
                    Text(eventViewModel.eventModel!.timedate,style: GoogleFonts.fredoka(fontSize: 13,fontWeight: FontWeight.w600),),
                    Text(eventViewModel.eventModel!.title,style: GoogleFonts.fredoka(fontSize: 25,fontWeight: FontWeight.w800),),
                    height10,
                    Text(eventViewModel.eventModel!.subtitle,style: GoogleFonts.fredoka(fontSize: 15,fontWeight: FontWeight.w400),),
                    height25,
                    //profile
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(15)),
                      child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      const CircleAvatar(radius: 30,),
                      const SizedBox(width: 10),
                      const Text("Developer Name"),
                      const Expanded(child: SizedBox()),
                      MaterialButton(onPressed: (){},color: Colors.blue,child: const Text("Follow"),padding: const EdgeInsets.all(20),)
                    ],),),
                    //title
                    Text("Select date and time",style: GoogleFonts.fredoka(fontSize: 24,fontWeight: FontWeight.bold)),
                    Container(width: double.infinity,height: 180,padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey.shade300),child: Column(
                      children: [
                        Text("22-4-2024 to 1-5-2024",style: GoogleFonts.fredoka()),
                        LimitedBox(maxWidth: double.infinity,maxHeight: 140,child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(10, (index) => Container(width:100,height: double.infinity,margin: const EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(8)),child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("October"),
                              CircleAvatar(child: Text("1")),
                              Text("8:30 PM"),
                            ],
                          ),),),
                        ),)
                      ],
                    ),),
                    //title
                    Text("Location",style: GoogleFonts.fredoka(fontSize: 24,fontWeight: FontWeight.bold)),
                    Text("Online",style: GoogleFonts.fredoka(fontSize: 15,fontWeight: FontWeight.w400),),
                    //title
                    height10,
                    Text("About event",style: GoogleFonts.fredoka(fontSize: 24,fontWeight: FontWeight.bold)),
                    height20,
                    Text(eventViewModel.eventModel!.about),
                  ],
                ),
              ),
              LimitedBox(
                maxWidth: (screenSize.width/2)*0.4,
                child: RegisterButton(height: columnHeight!=0?columnHeight:500),
              )
            ],
          ),
          Container(width: double.infinity,height: 200,color: Colors.grey),
        ],
      ),
    );
  }
}

class RegisterButton extends StatefulWidget {
  const RegisterButton({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        header: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Rs.500",style: GoogleFonts.fredoka(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(onPressed: (){},minWidth: double.infinity,height: 50,padding: EdgeInsets.all(10),color: Colors.deepOrange,child: Text("Get Ticket",style: GoogleFonts.aBeeZee(),),),
                )
              ],
            ),
          ),
        ),
        content: Container(
          alignment: Alignment.topCenter,
          height: widget.height,
          // color: Colors.black,
        ),
      );
  }
}

