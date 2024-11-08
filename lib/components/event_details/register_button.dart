import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'package:event_manager/home/models/event_model.dart';
import 'package:toastification/toastification.dart';

import '../../core/colors.dart';
import '../../event_details/views/ticket_register.dart';

class RegisterButtonForDesktop extends StatefulWidget {
  const RegisterButtonForDesktop({
    super.key,
    required this.height,
    required this.eventModel,
  });
  final double height;
  final EventModel eventModel;
  @override
  State<RegisterButtonForDesktop> createState() => _RegisterButtonForDesktopState();
}

class _RegisterButtonForDesktopState extends State<RegisterButtonForDesktop> {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        header: RegisterButton(eventModel: widget.eventModel),
        content: Container(
          alignment: Alignment.topCenter,
          height: widget.height,
          // color: Colors.black,
        ),
      );
  }
}

class RegisterButton extends StatefulWidget {
  const RegisterButton({
    super.key,
    required this.eventModel,
  });
  final EventModel eventModel;

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Text(int.parse(widget.eventModel.stock)<=0?"No Stock":widget.eventModel.fee=="0"?"Free":"Rs ${widget.eventModel.fee}",style: GoogleFonts.fredoka(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(onPressed: (){
                    if(int.parse(widget.eventModel.stock)<=0)return;
                    if(FirebaseAuth.instance.currentUser==null)
                    {
                      toastification.show(
                              title: const Text("You are not logged"),
                              style: ToastificationStyle.fillColored,
                              type: ToastificationType.error,
                              autoCloseDuration: const Duration(seconds: 4),
                              animationDuration:
                                  const Duration(milliseconds: 200),
                            );
                      return;
                    }
                    showDialog(context: context, builder: (context) => Dialog(child: CheckoutPage(eventModel: widget.eventModel),),);
                  },minWidth: double.infinity,height: 50,padding: const EdgeInsets.all(10),color: AppColor.primaryColor,child: Text("Get Ticket",style: GoogleFonts.aBeeZee(),),),
                )
              ],
            ),
          ),
        );
  }
}