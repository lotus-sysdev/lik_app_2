import 'package:dio/dio.dart';
import 'package:lik_app_2/core/constants/api_constants.dart';
import 'package:lik_app_2/core/utils/secure_storage.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = ApiConstants.connectTimeout;
    _dio.options.receiveTimeout = ApiConstants.receiveTimeout;

    _dio.interceptors.add(
      LogInterceptor(request: true, requestBody: true, responseBody: true),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage().getString("authToken");
          if (token != null) {
            options.headers[ApiConstants.authHeader] = 'Token $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Handle token refresh or logout
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        return 'Sesi telah berakhir, silakan login kembali';
      } else if (e.response?.data is Map &&
          e.response?.data['message'] != null) {
        return e.response?.data['message'];
      }
      return 'Terjadi kesalahan pada server (${e.response?.statusCode})';
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Koneksi timeout, periksa koneksi internet Anda';
        case DioExceptionType.connectionError:
          return 'Tidak dapat terhubung ke server';
        default:
          return 'Terjadi kesalahan tidak terduga';
      }
    }
  }
}
