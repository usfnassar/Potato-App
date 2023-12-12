import 'package:dio/dio.dart';
import 'package:potato_project/model/planet_data_model.dart';

class GetPlanetData {
  final dio = Dio();

  Future<PlanetDataModel> GetData() async {
    final response = await dio.get(
      'https://talented-silkworm-guiding.ngrok-free.app/data',
    );

    Map<String, dynamic> json = response.data;
    PlanetDataModel Data = PlanetDataModel.fromJson(json);
    return Data;
  }
}
