import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static Future<void> writeStorage(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String?> readStorage(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static Future<Map<String, String>> readAllStorage() async {
    const storage = FlutterSecureStorage();
    return await storage.readAll();
  }

  static Future<void> deleteStorage(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  static Future<void> deleteAllStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
