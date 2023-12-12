import 'package:dio/dio.dart';
import '../consts.dart';

class UpdateTreatment {
  final dio = Dio();

  Update(
      {required String? token,
      required String? id,
      required String plantId,
      required String treatment}) async {
    final response = await dio.patch(
      '$KUrl/admin/treatment',
      data: {"userId": id, "plantId": plantId, "treatment": treatment},
      options: Options(headers: {
        "Authorization": "bearer $token",
      }),
    );
  }
}
