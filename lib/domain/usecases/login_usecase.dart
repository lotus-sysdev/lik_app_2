import 'package:lik_app_2/domain/models/user.dart';
import 'package:lik_app_2/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<User> execute(String username, String password) {
    return repository.login(username, password);
  }
}
