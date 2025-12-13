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
    );
  }

  /// Forgot password API
  Future<void> forgotPassword(String email) async {
    await _client.post(
      ApiEndpoints.forgotPassword,
      {
        'email': email,
      },
    );
  }
}
