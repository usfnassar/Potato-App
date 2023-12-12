import 'package:dio/dio.dart';


class GetIdFromDisease{
  final dio = Dio();
  Future<int> GetId({required disease})async{

    final response = await dio.get(
      'https://talented-silkworm-guiding.ngrok-free.app/getid',data: {"imageDisease":disease}
    );

    Map<String, dynamic> json = response.data;
    int id = json["id"];
    return id;



  }
}
