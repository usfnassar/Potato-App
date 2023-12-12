import 'package:dio/dio.dart';
import 'package:potato_project/consts.dart';


class DeleteUserData{
  final dio = Dio();
  Future<String> DeleteUser({required String? token,required String? id})async{

    final response = await dio.delete(
      '$KUrl/admin/users', data: {"idOfUserWillDel": id,} ,
      options:Options(
          headers: {
            "Authorization":
            "bearer $token",
          }
      ),

    );

    Map<String, dynamic> json = response.data;

    return json['status'];



  }
}
