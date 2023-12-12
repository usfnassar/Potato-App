class LoginModel {
  String? status;
  Data? data;

  LoginModel({this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? token;
  String? userId;
  String? name;
  String? email;
  bool? isAdmin;

  Data({this.token, this.userId, this.name, this.email, this.isAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    isAdmin = json['isAdmin'];
  }

}

class loginError {
  String? status;
  ErrorData? data;

  loginError({this.status, this.data});

  loginError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ErrorData.fromJson(json['data']) : null;
  }

}

class ErrorData {
  String? msg;

  ErrorData({this.msg});

  ErrorData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

}