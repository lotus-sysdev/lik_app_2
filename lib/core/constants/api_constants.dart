class ApiConstants {
  static const String baseUrl = 'http://159.223.33.190:8001';

  // Auth
  static const String login = '/api/login_user/';

  // Petty Cash
  static const String pettyCashEmployees = '/api/pettycash/pegawai/';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Headers btgbf
  static const String authHeader = 'Authorization';
}
