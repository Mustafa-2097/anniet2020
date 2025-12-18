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
    String? name,
    String? phone,
  }) async {
    final Map<String, dynamic> body = {};

    if (name != null) body['name'] = name;
    if (phone != null) body['phone'] = phone;
    return await _client.patch(
      ApiEndpoints.updateProfile,
      body,
    );
  }
  /// Upload avatar
  Future<Map<String, dynamic>> uploadAvatar(String imagePath) async {
    return await _client.patchMultipart(
      url: ApiEndpoints.updateAvatar,
      filePath: imagePath,
      fileField: 'avatar',
    );
  }

  /// Course
  Future<Map<String, dynamic>> fetchCourses() async {
    return await _client.get(ApiEndpoints.courses);
  }
  Future<Map<String, dynamic>> fetchCourseDetails(String courseId) async {
    return await _client.get("${ApiEndpoints.courses}/$courseId");
  }

  /// Logout API (requires access token)
  Future<void> logout() async {
    await _client.post(ApiEndpoints.logout, {});
  }
}
