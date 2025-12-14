import '../../../../core/offline_storage/shared_pref.dart';
import '../api_providers/user_api_provider.dart';

class UserRepository {
  final UserApiProvider _provider = UserApiProvider();

  /// Fetch profile use-case
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _provider.fetchProfile();

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to load profile');
    }

    return response['data'];
  }

  /// Update profile
  Future<void> updateProfile({
    required String name,
    String? phone,
  }) async {
    final response = await _provider.updateProfile(
      name: name,
      phone: phone,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Profile update failed');
    }
  }

  /// Logout use-case
  Future<void> logout() async {
    await _provider.logout();
    /// Clear local token after successful logout
    await SharedPreferencesHelper.clearToken();
  }
}
