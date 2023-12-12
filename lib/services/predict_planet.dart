import 'package:dio/dio.dart';
import 'package:potato_project/model/planet_model.dart';

class PredictPlanet{
  final dio = Dio();
  Future<PlanetModel> predict({required String im64})async{

    final response = await dio.post(
        'https://talented-silkworm-guiding.ngrok-free.app/classify', data:
    {
      "image_data": im64,
    });


    Map<String, dynamic> json = response.data;

    PlanetModel prediction = PlanetModel.fromJson(json);

    return prediction;



  }
}
