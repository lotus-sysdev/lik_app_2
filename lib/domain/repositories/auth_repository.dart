import 'package:lik_app_2/domain/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<bool> hasToken();
  Future<void> logout();
}
