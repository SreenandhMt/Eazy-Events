import 'package:event_manager/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3,top: 3.5),
          child: Text("EazyEvents",style: GoogleFonts.concertOne(fontSize: 20,color: Colors.black),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2,top: 2.5),
          child: Text("EazyEvents",style: GoogleFonts.concertOne(fontSize: 20,color: Colors.pink),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1.5,top: 2),
          child: Text("EazyEvents",style: GoogleFonts.concertOne(fontSize: 20,color: Colors.green),),
        ),
        Padding(
         padding: const EdgeInsets.only(left: 1,top: 1.5),
          child: Text("EazyEvents",style: GoogleFonts.concertOne(fontSize: 20,color: Colors.amber),),
        ),
        GestureDetector(onTap: ()=>context.go("/"),child: Text("EazyEvents",style: GoogleFonts.concertOne(fontSize: 20,color: AppColor.primaryColor)))
      ],
    );
  }
}