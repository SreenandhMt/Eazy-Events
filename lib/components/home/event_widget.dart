import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../event_details/view_models/event_view_model.dart';
import '../../home/models/event_model.dart';
import '../../utils/navigation_utils.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    required this.eventModel,
  });
  final EventModel eventModel;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                onTap: () {
                   context.read<EventViewModel>().setEventData(widget.eventModel);
                   AppNavigation.eventDetailsPage(context,widget.eventModel.id);
                },
                child: Container(width: 350,height: 300,decoration: BoxDecoration(color: Colors.grey.shade300,image:widget.eventModel.poster.isEmpty?null: DecorationImage(image: NetworkImage(widget.eventModel.poster),fit: BoxFit.fitHeight),borderRadius: BorderRadius.circular(10)),child: Stack(
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
                            Text(widget.eventModel.title,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18),maxLines: 1),
                          Text(DateFormat.yMMMMd('en_US').format(DateTime.parse(widget.eventModel.date)),style: const TextStyle(fontSize: 15),maxLines: 1),
                          Text(widget.eventModel.fee=="0"?"Free":"Fee ₹${widget.eventModel.fee}",style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 15),maxLines: 1),
                          Text(widget.eventModel.createrName,style: const TextStyle(fontSize: 15),maxLines: 1),
                          ],
                        ),
                      ),
                    ),)
                  ],
                ),),
              ),
              );
  }
}