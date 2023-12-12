import 'package:dio/dio.dart';
import 'package:potato_project/model/get_search_model.dart';
import '../consts.dart';

class GetUserSearch{
  final dio = Dio();
  Future<GetSearch> GetSearchData({required String? id})async{

    final response = await dio.get(
      '$KUrl/plant/recent', data: {"userId": id,} ,
    );

    Map<String, dynamic> json = response.data;
    GetSearch SearchData = GetSearch.fromJson(json);
    return SearchData;



  }
}
