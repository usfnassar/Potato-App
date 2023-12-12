class GetUsers {
  String? status;
  List<Users>? users;

  GetUsers({this.status, this.users});

  GetUsers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

}

class Users {
  String? sId;
  String? name;
  String? email;
  String? password;
  bool? isAdmin;
  List<String>? plants;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Users(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.isAdmin,
        this.plants,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Users.fromJson(Map<String, dynamic> json) {
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