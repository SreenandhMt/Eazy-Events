import 'package:flutter/material.dart';

import '../../core/size.dart';
import '../../utils/dark_check.dart';

class DashboardTextform extends StatefulWidget {
  const DashboardTextform({
    super.key,
    required this.text,
    this.width,
    this.maxLine,
    this.maxLength,
    this.padding,
    this.controller,
    this.validator,
  });
  final  String text;
  final double? width;
  final int? maxLine;
  final int? maxLength;
  final double? padding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<DashboardTextform> createState() => _DashboardTextformState();
}

class _DashboardTextformState extends State<DashboardTextform> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding??8.0),
      child: TextFormField(validator: widget.validator,controller: widget.controller,maxLines: widget.maxLine??1,minLines: widget.maxLine==null?1:3,maxLength: widget.maxLength,decoration: InputDecoration(fillColor:Colors.transparent,border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),hintText: widget.text),cursorColor: Colors.green,),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.text,
    this.subtitle,
  }) : super(key: key);
  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 6,bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500,color:isDarkTheme(context)? Colors.white:Colors.black)),
                          if(subtitle!=null)...[
                            height5,
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(subtitle!,style: const TextStyle(fontSize: 13),),
                          )
                          ],
                ],
              ),
            );
  }
}