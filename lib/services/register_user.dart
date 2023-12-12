import 'package:dio/dio.dart';
import 'package:potato_project/consts.dart';
import 'package:potato_project/model/register_model.dart';

class Register{
  final dio = Dio();
  Future<RegisterModel> RegisterUser({required String email,required String password ,required String name})async{

    final response = await dio.post(
        '$KUrl/auth/signup', data:
    {
      "email": email,
      "password": password,
      "name": name,
    });


    Map<String, dynamic> json = response.data;
    RegisterModel userData = RegisterModel.fromJson(json);
    return userData;



  }
}
