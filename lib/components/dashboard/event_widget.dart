import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:event_manager/home/models/event_model.dart';

import '../../core/colors.dart';

class DashboardEventWidget extends StatefulWidget {
  const DashboardEventWidget({
    super.key,
    required this.myEvents,
    this.onTap,
  });
  final EventModel myEvents;
  final void Function()? onTap;

  @override
  State<DashboardEventWidget> createState() => _DashboardEventWidgetState();
}

class _DashboardEventWidgetState extends State<DashboardEventWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
              onTap: widget.onTap,
              child: Container(width: 350,height: 300,decoration: BoxDecoration(color: Colors.grey.shade700,image:widget.myEvents.poster.isEmpty?null: DecorationImage(image: NetworkImage(widget.myEvents.poster),fit: BoxFit.fitHeight),borderRadius: BorderRadius.circular(10)),child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(alignment: Alignment.bottomCenter,child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(color: AppColor.secondaryColor(context),borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.myEvents.title,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18),maxLines: 1),
                          Text(DateFormat.yMMMMd('en_US').format(DateTime.parse(widget.myEvents.date)),style: const TextStyle(fontSize: 15),maxLines: 1),
                          Text(widget.myEvents.fee=="0"?"Free":"Fee ₹${widget.myEvents.fee}",style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 15),maxLines: 1),
                          Text(widget.myEvents.createrName,style: const TextStyle(fontSize: 15),maxLines: 1),
                        ],
                      ),
                    ),
                  ),)
                ],
              ),),
            );
  }
}