import 'package:dio/dio.dart';
import 'package:potato_project/model/login_model.dart';

import '../consts.dart';

class Login{
  final dio = Dio();
   Future<LoginModel> LoginUser({required String email,required String password })async{

       final response = await dio.post(
           '$KUrl/auth/signin', data:
       {
         "email": email,
         "password": password,
       });


         Map<String, dynamic> json = response.data;
         LoginModel userData = LoginModel.fromJson(json);
         return userData;



}
   }
