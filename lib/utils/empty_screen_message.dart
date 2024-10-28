import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/size.dart';
import 'dark_check.dart';

class EmptyScreenMessage extends StatefulWidget {
  const EmptyScreenMessage({
    Key? key,
    required this.text,
    required this.icon,
    this.hideButton,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final bool? hideButton;

  @override
  State<EmptyScreenMessage> createState() => _EmptyScreenMessageState();
}

class _EmptyScreenMessageState extends State<EmptyScreenMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50,backgroundColor: isDarkTheme(context)?Colors.white:Colors.black,child: Icon(widget.icon,size: 40,),),
            height20,
            Text(widget.text,style: GoogleFonts.aBeeZee(fontSize: 30),),
            height10,  
            if(widget.hideButton==null||!widget.hideButton!)
            TextButton(onPressed: ()=>context.go("/"), child: Text("Go Back",style: GoogleFonts.aBeeZee(fontSize: 20))),
          ],
        ),
      ));
  }
}
