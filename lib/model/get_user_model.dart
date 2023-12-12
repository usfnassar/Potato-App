class GetUserData {
  User? user;

  GetUserData({this.user});

  GetUserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  bool? isAdmin;
 late List<String> plants;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.isAdmin,
       required this.plants,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    plants = json['plants'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

}