import 'package:lik_app_2/data/datasources/auth_remote_data_source.dart';
import 'package:lik_app_2/domain/models/user.dart';
import 'package:lik_app_2/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(String username, String password) =>
      remoteDataSource.login(username, password);

  @override
  Future<bool> hasToken() => remoteDataSource.hasToken();

  @override
  Future<void> logout() => remoteDataSource.logout();
}
