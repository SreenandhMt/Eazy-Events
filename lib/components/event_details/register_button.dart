import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../core/colors.dart';

class RegisterButton extends StatefulWidget {
  const RegisterButton({
    super.key,
    required this.height,
  });
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
          decoration: BoxDecoration(color: AppColor.secondaryColor(context),borderRadius: BorderRadius.circular(10)),
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
                  child: MaterialButton(onPressed: (){},minWidth: double.infinity,height: 50,padding: const EdgeInsets.all(10),color: AppColor.primaryColor,child: Text("Get Ticket",style: GoogleFonts.aBeeZee(),),),
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