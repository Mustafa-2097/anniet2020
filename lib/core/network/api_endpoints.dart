class ApiEndpoints {
  /// Base URL
  // static const String baseUrl = 'https://anniet-server.vercel.app/api/v1';
  static const String baseUrl = 'http://206.162.244.168:5002/api/v1';

  /// Auth
  static const String register = '$baseUrl/auth/register';
  static const String verifySigUupOtp = '$baseUrl/auth/verify-otp';
  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';

  /// Forgot Password
  static const String sendResetOtp = '$baseUrl/auth/send-otp/password-reset';
  static const String verifyResetOtp = '$baseUrl/auth/verify-otp/password-reset';
  /// Reset password (NEW)
  static const String resetPassword = '$baseUrl/auth/reset-password';

  /// User / Profile
  static const String profile = '$baseUrl/me/profile';
  static const String updateProfile = '$baseUrl/me/profile';
}

