import 'package:dio/dio.dart';
import 'package:flutter_package_sample/models/api/request/coffee.dart';

class CoffeeApiClient {
  Future<List<Coffee>?> fetchList() async {
    final dio = Dio();
    const url = 'https://api.sampleapis.com/coffee/hot';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      try {
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => Coffee.fromJson(e)).toList();
        return list;
      } catch (e) {
        rethrow;
      }
    }
    return null;
  }
}
