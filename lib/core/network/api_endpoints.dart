class ApiEndpoints {
  /// Base URL
  static const String baseUrl = 'https://anniet-server.vercel.app/api/v1';

  /// Auth
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';

  static const String logout = '$baseUrl/auth/logout';

  /// User / Profile
  static const String profile = '$baseUrl/me/profile';
}
