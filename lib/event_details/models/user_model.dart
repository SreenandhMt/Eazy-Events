class UserModel {
  final String name;
  final String profilePhoto;
  final String email;
  final String uid;
  final List<dynamic> followers;
  final List<dynamic> following;

  UserModel({
    required this.name,
    required this.profilePhoto,
    required this.email,
    required this.uid,
    required this.followers,
    required this.following,
  });
  factory UserModel.formjson(Map e)
  {
    return UserModel(uid: e["uid"],name: e["name"], profilePhoto: e["photo"], email: e["email"], followers: e["followers"], following: e["following"]);
  }
}
