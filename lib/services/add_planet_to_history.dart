import 'package:dio/dio.dart';
import 'package:potato_project/consts.dart';


class AddPlanetData{
  final dio = Dio();
  Future<String> AddPlanet({
    required String? id,
    required String? planetName,
    required String? planetDisease,
    required String? plantId,
    required bool? hasDisease,
    required String? image,
  })async{

    final response = await dio.post(
      '$KUrl/plant/upload', data: {
      "userId":id,
      "plantName": planetName,
      "plantDisease": planetDisease,
      "hasDisease": hasDisease,
      "image":image,
      "plantId":plantId,

    } ,

    );

    Map<String, dynamic> json = response.data;

    return json['status'];



  }
}
