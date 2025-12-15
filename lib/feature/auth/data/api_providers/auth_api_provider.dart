import '../../../../core/network/http_client.dart';
import '../../../../core/network/api_endpoints.dart';

class AuthApiProvider {
  final HttpClient _client = HttpClient();

  /// Register API
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _client.post(
      ApiEndpoints.register,
      {
        'name': name,
        'email': email,
        'password': password,
      },
      withAuth: false,
    );
  }
  /// Verify OTP for signup
  Future<Map<String, dynamic>> verifySigUupOtp({
    required String email,
    required String otp,
  }) async {
    return await _client.post(
      ApiEndpoints.verifySigUupOtp,
      {
        'email': email,
        'otp': otp,
      },
      withAuth: false,
    );
  }

  /// Login API
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await _client.post(
      ApiEndpoints.login,
      {
        'email': email,
        'password': password,
      },
      withAuth: false,
    );
  }

  /// Send OTP
  Future<Map<String, dynamic>> sendResetOtp(String email) async {
    return await _client.post(
      ApiEndpoints.sendResetOtp,
      {'email': email},
      withAuth: false,
    );
  }

  /// Verify OTP
  Future<Map<String, dynamic>> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    return await _client.post(
      ApiEndpoints.verifyResetOtp,
      {
        'email': email,
        'otp': otp,
      },
      withAuth: false,
    );
  }

  /// Reset password
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String password,
  }) async {
    return await _client.post(
      ApiEndpoints.resetPassword,
      {
        'token': token,
        'password': password,
      },
      withAuth: false,
    );
  }
}
