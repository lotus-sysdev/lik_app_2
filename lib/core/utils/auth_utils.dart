import 'package:lik_app_2/core/utils/secure_storage.dart';

class AuthUtils {
  final SecureStorage _storage;

  AuthUtils(this._storage);

  Future<bool> checkToken() async {
    try {
      final token = await _storage.getString("authToken");
      return token != null;
    } catch (e) {
      throw Exception("Token check failed: ${e.toString()}");
    }
  }
}
