import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:event_manager/components/event_details/profile_widget.dart';
import 'package:event_manager/components/event_details/register_button.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/utils/dark_check.dart';

import '../../core/colors.dart';
import '../../core/size.dart';
import '../../home/models/event_model.dart';

// text style

TextStyle textStyleFredoka({double? fontSize,FontWeight? fontWeight,Color? color}){
  return GoogleFonts.fredoka(fontSize: fontSize,fontWeight: fontWeight,color: color);
}

class EventDetailsDesktopView extends StatefulWidget {
  const EventDetailsDesktopView({
    super.key,
  });

  @override
  State<EventDetailsDesktopView> createState() =>
      _EventDetailsDesktopViewState();
}

class _EventDetailsDesktopViewState extends State<EventDetailsDesktopView> {
  final _key = GlobalKey();
  double columnHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getColumnHeight();
    });
  }

  void _getColumnHeight() {
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LimitedBox(
              maxWidth: (screenSize.width / 2),
              child: Column(
                // key to get column hight
                key: _key,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height20,
                  Text(
                      DateFormat.yMMMMd('en_US').format(DateTime.parse(eventViewModel.eventModel!.date)),
                      style: textStyleFredoka(
                          fontSize: 13, fontWeight: FontWeight.w600,
                      ),
                  ),
                  Text(
                    eventViewModel.eventModel!.title,
                    style: GoogleFonts.kanit(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  height10,
                  Text(
                    eventViewModel.eventModel!.subtitle,
                    style:textStyleFredoka(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  height25,

                  //profile
                  ProfileWidget(userModel: eventViewModel.userModel!, createrID: eventViewModel.eventModel!.createrid, isFollowed: eventViewModel.userFollowed),
                  height10,
                  //Date title
                  Text("Date and time",style: textStyleFredoka(fontSize: 24, fontWeight: FontWeight.bold)),
                  height10,
                  // time title
                  DateAndTimeWidget(eventModel: eventViewModel.eventModel!),
                  height10,
                  //location
                  Text("Location",
                      style: textStyleFredoka(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(
                    "Online",
                    style: textStyleFredoka(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  height10,
                  //about
                  Text("About event",
                      style: textStyleFredoka(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  height20,
                  TextParser(text: eventViewModel.eventModel!.about),
                  // registration details
                  if(eventViewModel.eventModel!.registrationDetails!=null&&eventViewModel.eventModel!.registrationDetails!.isNotEmpty)...[
                    height10,
                    Text("Regisraction details",style: textStyleFredoka(fontSize: 24, fontWeight: FontWeight.bold)),
                    height20,
                    TextParser(text:eventViewModel.eventModel!.registrationDetails!),
                  ],
                ],
              ),
            ),
            LimitedBox(
              maxWidth: (screenSize.width / 2) * 0.4,
              child: RegisterButtonForDesktop(
                height: columnHeight != 0 ? columnHeight : 500,
                eventModel: eventViewModel.eventModel!,
              ),
            )
          ],
        ),
        height35,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: const Center(child: Text("© 2024 EazyEvent")),
        ),
      ],
    );
  }
}

class DateAndTimeWidget extends StatefulWidget {
  const DateAndTimeWidget({
    Key? key,
    required this.eventModel,
    this.width,
  }) : super(key: key);
  final EventModel eventModel;
  final double? width;

  @override
  State<DateAndTimeWidget> createState() => _DateAndTimeWidgetState();
}

class _DateAndTimeWidgetState extends State<DateAndTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
                    width:widget.width?? 300,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.secondaryColor(context),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US').format(
                              DateTime.parse(widget.eventModel.date)),
                          style: textStyleFredoka(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        height10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColor.tertiaryColor(context)),
                                child: Text(widget.eventModel.startTime, style: textStyleFredoka(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                                                        )),
                              ),
                            ),
                            width10,
                            Text("TO"),
                            width10,
                            Card(
                              child: Container(
                                 padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColor.tertiaryColor(context)),
                                child: Text(widget.eventModel.endTime, style: textStyleFredoka(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                                                        )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
  }
}

class TextParser extends StatelessWidget {
  final String text;

  const TextParser({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _parseText(text, isDarkTheme(context)),
        style: TextStyle(color: isDarkTheme(context) ? Colors.white60 : Colors.black87),
      ),
    );
  }

  List<InlineSpan> _parseText(String text, bool isDarkMode) {
    final List<InlineSpan> spans = [];

    // Updated regex to detect bold (**text**), italic (*text*), images, and links
    final RegExp regExp = RegExp(r'\*\*(.*?)\*\*|\*(.*?)\*|<?(https?:\/\/\S*(img|image)\S*)>?|(https?:\/\/\S+)');
    final Iterable<RegExpMatch> matches = regExp.allMatches(text);

    int lastMatchEnd = 0;
    if (matches.isEmpty) {
      spans.add(TextSpan(text: text,style: TextStyle(color: isDarkMode ? Colors.white54 : Colors.black54, fontWeight: FontWeight.w600, fontSize: 15))); // Fallback to full text if no matches
      return spans;
    }

    for (final match in matches) {
      if (lastMatchEnd < match.start) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: TextStyle(color: isDarkMode ? Colors.white54 : Colors.black54, fontWeight: FontWeight.w600, fontSize: 15),
        ));
      }

      if (match.group(1) != null) {
        // Bold text
        spans.add(TextSpan(
          text: match.group(1)!,
          style: TextStyle(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black, fontSize: 15),
        ));
      } else if (match.group(2) != null) {
        // Italic text
        spans.add(TextSpan(
          text: match.group(2)!,
          style: TextStyle(fontStyle: FontStyle.italic, color: isDarkMode ? Colors.white54 : Colors.black54, fontWeight: FontWeight.w600, fontSize: 15),
        ));
      } else if (match.group(3) != null) {
        // Image URL
        final String imageUrl = match.group(3)!.replaceAll(RegExp(r'[<>]'), '');
        spans.add(const TextSpan(text: '\n'));
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ));
      } else if (match.group(5) != null) {
        // Link text
        final String linkUrl = match.group(5)!;
        spans.add(TextSpan(
          text: linkUrl,
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 15),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _openLink(linkUrl);
            },
        ));
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: TextStyle(color: isDarkMode ? Colors.white54 : Colors.black54, fontWeight: FontWeight.w600, fontSize: 15),
      ));
    }

    return spans;
  }

  void _openLink(String url) async{
    await launchUrl(Uri.parse(url));
  }

}