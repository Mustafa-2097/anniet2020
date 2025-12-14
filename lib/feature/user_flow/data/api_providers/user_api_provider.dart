import '../../../../core/network/http_client.dart';
import '../../../../core/network/api_endpoints.dart';

class UserApiProvider {
  final HttpClient _client = HttpClient();

  /// Get user profile
  Future<Map<String, dynamic>> fetchProfile() async {
    return await _client.get(ApiEndpoints.profile);
  }

  /// Update profile
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    String? phone,
  }) async {
    return await _client.patch(
      ApiEndpoints.updateProfile,
      {
        "name": name,
        if (phone != null) "phone": phone,
      },
    );
  }

  /// Logout API (requires access token)
  Future<void> logout() async {
    await _client.post(ApiEndpoints.logout, {});
  }
}
