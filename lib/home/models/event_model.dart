class EventModel {
  final String about;
  final String title;
  final String timedate;
  final String subtitle;
  final String createrid;
  final String id;
  final String location;
  final dynamic registerEnd;
  final List<dynamic> poster;
  final List<dynamic> tags;

  EventModel({required this.about, required this.title, required this.timedate, required this.subtitle, required this.createrid, required this.id, required this.location, required this.registerEnd, required this.poster, required this.tags});

  factory EventModel.formjson(Map e)
  {
    return EventModel(about: e["about"], title: e["title"], timedate: e["datetime"], subtitle: e["subtitle"], createrid: e["createrid"], id: e["id"], location: e["location"], registerEnd: e["register-end"]??"", poster: e["poster"]??[], tags: e["tag"]);
  }
  
}