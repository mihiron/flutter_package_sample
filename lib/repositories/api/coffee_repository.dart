import 'package:flutter_package_sample/services/api/coffee_api_client.dart';

class CoffeeRepository {
  final api = CoffeeApiClient();
  dynamic fetchList() async {
    return await api.fetchList();
  }
}
