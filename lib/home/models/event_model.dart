import 'dart:developer';

class EventModel {
  final String title;
  final String subtitle;
  final String about;
  final String? registrationDetails;
  final String date;
  final String startTime;
  final String endTime;
  final String createrid;
  final String createrName;
  final String category;
  final String fee;
  final String stock;
  final String id;
  final String location;
  final dynamic registerEnd;
  final String poster;

  EventModel({
    required this.title,
    required this.subtitle,
    required this.about,
    this.registrationDetails,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.createrid,
    required this.createrName,
    required this.category,
    required this.fee,
    required this.stock,
    required this.id,
    required this.location,
    required this.registerEnd,
    required this.poster,
  });

  factory EventModel.formjson(Map e)
  {
    return EventModel(about: e["about"], title: e["title"],registrationDetails: e["registration"],category: e["category"],createrName: e["creatername"],stock: e["stock"],fee: e["fee"],startTime: e["starttime"], endTime: e["endtime"],date: e["date"]??"", subtitle: e["subtitle"], createrid: e["createrid"], id: e["id"], location: e["location"], registerEnd:"", poster: e["poster"]??"");
  }
  
}
