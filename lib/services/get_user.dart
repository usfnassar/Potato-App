import 'package:dio/dio.dart';
import 'package:potato_project/model/get_user_model.dart';


import '../consts.dart';

class GetUserProfile {
  final dio = Dio();

  Future<GetUserData> GetProfileData({required String? id}) async {
    final response = await dio.get(
      '$KUrl/admin/user',
      data: {
        "userId": id,
      },
    );

    Map<String, dynamic> json = response.data;
    GetUserData UserData = GetUserData.fromJson(json);
    return UserData;
  }
}
