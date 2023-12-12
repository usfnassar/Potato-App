class GetTreatmentModel {
  String? status;
  late Data data;

  GetTreatmentModel({this.status, required this.data});

  GetTreatmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = new Data.fromJson(json['data']);
  }

}

class Data {
  late String treatment;

  Data({required this.treatment});

  Data.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment'];
  }

}