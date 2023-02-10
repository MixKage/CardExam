import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecretInfo { loginOrEmail, password, jwt }

class SecurityStorage {
  SecurityStorage._();

  static SecurityStorage instance = SecurityStorage._();

  factory SecurityStorage() => instance;

  final storage = const FlutterSecureStorage();

  Future<String?> getSecret(SecretInfo secret) async =>
      storage.read(key: secret.name);

  Future<void> setSecret(SecretInfo secret, String value) async {
    await storage.write(key: secret.name, value: value);
  }

  Future<void> deleteAll() async => storage.deleteAll();
}
