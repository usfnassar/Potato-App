class RegisterModel {
  String? status;
  Data? data;

  RegisterModel({this.status, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? userId;

  Data({this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }
}
class RegisterError {
  String? status;
  RegisterErrorData? data;

  RegisterError({this.status, this.data});

  RegisterError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new RegisterErrorData.fromJson(json['data']) : null;
  }

}

class RegisterErrorData {
  String? msg;

  RegisterErrorData({this.msg});

  RegisterErrorData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }
}