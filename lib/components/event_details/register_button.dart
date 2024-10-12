import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'package:event_manager/home/models/event_model.dart';

import '../../core/colors.dart';
import 'ticket_register.dart';

class RegisterButton extends StatefulWidget {
  const RegisterButton({
    Key? key,
    required this.height,
    required this.fee,
    required this.eventID,
    required this.createrID,
    required this.stock,
    required this.eventModel,
  }) : super(key: key);
  final double height;
  final String fee;
  final String eventID;
  final String createrID;
  final String stock;
  final EventModel eventModel;
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
          decoration: BoxDecoration(color: AppColor.secondaryColor(context),borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(int.parse(widget.stock)<=0?"No Stock":widget.fee=="0"?"Free":"Rs ${widget.fee}",style: GoogleFonts.fredoka(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(onPressed: (){
                    if(int.parse(widget.stock)<=0)return;
                    showDialog(context: context, builder: (context) => Dialog(child: CheckoutPage(eventModel: widget.eventModel),),);
                  },minWidth: double.infinity,height: 50,padding: const EdgeInsets.all(10),color: AppColor.primaryColor,child: Text("Get Ticket",style: GoogleFonts.aBeeZee(),),),
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