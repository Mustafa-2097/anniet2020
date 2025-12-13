import '../../../../core/network/http_client.dart';
import '../../../../core/network/api_endpoints.dart';

class UserApiProvider {
  final HttpClient _client = HttpClient();

  /// Get user profile
  Future<Map<String, dynamic>> fetchProfile() async {
    return await _client.get(ApiEndpoints.profile);
  }

  /// Logout API (requires access token)
  Future<void> logout() async {
    await _client.post(ApiEndpoints.logout, {});
  }
}
