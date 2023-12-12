import 'package:dio/dio.dart';
import 'package:potato_project/model/users_model.dart';
import '../consts.dart';

class GetUserData {
  final dio = Dio();

  Future<List<Users>> UsersList(
      {required String? token, required String? id}) async {
    final response = await dio.get(
      '$KUrl/admin/users',
      data: {
        "id": id,
      },
      options: Options(headers: {
        "Authorization": "bearer $token",
      }),
    );

    Map<String, dynamic> json = response.data;
    GetUsers ListUserData = GetUsers.fromJson(json);
    return ListUserData.users!;
  }
}
