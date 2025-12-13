import '../../../../core/offline_storage/shared_pref.dart';
import '../api_providers/auth_api_provider.dart';

class AuthRepository {
  final AuthApiProvider _provider = AuthApiProvider();

  /// Register use-case
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _provider.register(
      name: name,
      email: email,
      password: password,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Registration failed');
    }
  }

  /// Login use-case
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _provider.login(
      email: email,
      password: password,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Login failed');
    }

    /// Token save
    final token = response['data']['token']; // backend অনুযায়ী adjust
    if (token != null) {
      await SharedPreferencesHelper.saveToken(token);
    }
  }

  /// Forgot password use-case
  Future<void> forgotPassword(String email) async {
    await _provider.forgotPassword(email);
  }
}
