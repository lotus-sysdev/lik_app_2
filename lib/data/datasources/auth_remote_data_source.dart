import 'package:lik_app_2/core/constants/api_constants.dart';
import 'package:lik_app_2/core/network/dio_client.dart';
import 'package:lik_app_2/core/utils/secure_storage.dart';
import 'package:lik_app_2/domain/models/user.dart';
import 'package:lik_app_2/domain/repositories/auth_repository.dart';

class AuthRemoteDataSource implements AuthRepository {
  final DioClient dioClient;

  AuthRemoteDataSource(this.dioClient);

  @override
  Future<User> login(String username, String password) async {
    final response = await dioClient.post(
      ApiConstants.login,
      data: {"username": username, "password": password},
    );

    final data = response.data;
    if (data['token'] == null || data['user'] == null) {
      throw Exception('Invalid server response');
    }

    return User.fromJson(data);
  }

  @override
  Future<bool> hasToken() async {
    final storage = SecureStorage();
    final token = await storage.getString("authToken");
    return token != null;
  }

  @override
  Future<void> logout() async {
    final storage = SecureStorage();
    await storage.clearAll();
  }
}
