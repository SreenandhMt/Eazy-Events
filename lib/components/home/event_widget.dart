import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          // click events
          context.read<EventViewModel>().setEventData(widget.eventModel);
          AppNavigation.eventDetailsPage(context, widget.eventModel.id);
        },
        child: Container(
          width: 350,
          height: 300,
          decoration: BoxDecoration(
              color: AppColor.secondaryColor(context),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            children: [

              // poster image widget
              Expanded(
                  child: CachedNetworkImage(
                imageUrl: widget.eventModel.poster,
                width: double.infinity,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              )),

              //event details
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                    color: AppColor.secondaryColor(context),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 6, right: 5, bottom: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.eventModel.title,
                          style: GoogleFonts.kanit(
                              fontWeight: FontWeight.w700, fontSize: 18),
                          maxLines: 1),
                      Text(
                          DateFormat.yMMMMd('en_US')
                              .format(DateTime.parse(widget.eventModel.date)),
                          style: const TextStyle(fontSize: 15),
                          maxLines: 1),
                      Text(
                          widget.eventModel.fee == "0"
                              ? "Free"
                              : "From ₹${widget.eventModel.fee}",
                          style:
                              GoogleFonts.kanit(),
                          maxLines: 1),
                      Text(widget.eventModel.createrName,
                          style: GoogleFonts.kanit(fontSize: 15), maxLines: 1),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}