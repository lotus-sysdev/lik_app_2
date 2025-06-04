// lib/core/providers/auth_repository_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lik_app_2/core/network/dio_client.dart';
import 'package:lik_app_2/data/datasources/auth_remote_data_source.dart';
import 'package:lik_app_2/data/repositories/auth_repository_impl.dart';
import 'package:lik_app_2/domain/repositories/auth_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.read(dioClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});
