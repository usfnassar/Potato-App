import 'package:dio/dio.dart';
import 'package:potato_project/model/planet_data_model.dart';

import '../consts.dart';

class GetPlanetData {
  final dio = Dio();

  Future<PlanetDataModel> GetData() async {
    final response = await dio.get(
      '$KApi/data',
    );

    Map<String, dynamic> json = response.data;
    PlanetDataModel Data = PlanetDataModel.fromJson(json);
    return Data;
  }
}
