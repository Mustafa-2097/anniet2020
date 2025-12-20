import '../../../../core/offline_storage/shared_pref.dart';
import '../../courses/models/course_model.dart';
import '../../lessons/models/lesson_model.dart';
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
  Future<void> updateProfile({String? name, String? phone}) async {
    final response = await _provider.updateProfile(name: name, phone: phone);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Profile update failed');
    }
  }
  /// Upload avatar
  Future<String> uploadAvatar(String imagePath) async {
    final response = await _provider.uploadAvatar(imagePath);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Avatar upload failed');
    }
    return response['data']['avatar'];
  }
  /// Contact Us via Message
  Future<void> contactUs(String message) async {
    final response = await _provider.contactUs(message);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? "Failed to send message");
    }
  }
  /// Educate Employee use-case
  Future<void> educateEmployee({
    required String companyName,
    required int employeeCount,
    required String message,
  }) async {
    final response = await _provider.educateEmployee(
      companyName: companyName,
      employeeCount: employeeCount,
      message: message,
    );
    if (response['success'] != true) {
      throw Exception(response['message'] ?? "Failed to send request");
    }
  }



  /// Course
  Future<List<Course>> getCourses() async {
    final response = await _provider.fetchCourses();
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to load courses');
    }
    final List list = response['data'];
    return list.map((e) => Course.fromJson(e)).toList();
  }
  /// Lessons
  Future<List<LessonModel>> getLessons(String courseId) async {
    final response = await _provider.fetchCourseDetails(courseId);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? "Failed to load lessons");
    }
    final List lessons = response['data']['lessons'];
    return lessons.map((e) => LessonModel.fromJson(e)).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }
  /// Next Video
  Future<LessonModel?> getNextVideo(String courseId) async {
    final response = await _provider.getNextVideo(courseId);
    if (response['success'] != true) return null;
    return LessonModel.fromJson(response['data']);
  }



  /// Logout use-case
  Future<void> logout() async {
    await _provider.logout();
    /// Clear local token after successful logout
    await SharedPreferencesHelper.clearToken();
  }
}
