import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_package_sample/src/models/api/request/coffee.dart';

class CoffeeApiClient {
  Future<List<Coffee>?> fetchList() async {
    final dio = Dio();
    const url = 'https://api.sampleapis.com/coffee/hot';

    HttpOverrides.global = PermitInvalidCertification();

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

// エラーの対策　https://devlights.hatenablog.com/entry/2021/08/27/145704
class PermitInvalidCertification extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
