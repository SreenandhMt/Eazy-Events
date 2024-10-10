class TicketModel {
  final String userName;
  final String userProfile;
  final String userNumber;
  final String eventID;
  final String email;
  final String uid;
  final String ticketID;
  final String createrID;

  TicketModel({
    required this.userName,
    required this.userProfile,
    required this.userNumber,
    required this.eventID,
    required this.email,
    required this.uid,
    required this.ticketID,
    required this.createrID,
  });

  factory TicketModel.formjson(Map e)
  {
    return TicketModel(userName: e["userName"], userProfile: e["userPhoto"], userNumber: e["contactNumber"], eventID: e["eventID"], email: e["userEmail"], uid: e["uid"], ticketID: e["ticketID"],createrID: e["createrID"]);
  }
}
