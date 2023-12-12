import 'package:dio/dio.dart';
import 'package:potato_project/consts.dart';
import 'package:potato_project/model/treatment_model.dart';

class GetTreatment{
  final dio = Dio();
  Future<GetTreatmentModel> Treatment({required String userId,required String plantId})async{

    final response = await dio.get(
        '$KUrl/admin/treatment', data:
    {
      "userId": userId,
      "plantId": plantId,
    });


    Map<String, dynamic> json = response.data;

    GetTreatmentModel treatment = GetTreatmentModel.fromJson(json);

    return treatment;

  }
}
