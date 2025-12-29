import 'package:flutter/material.dart';
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
    debugPrint('Updating profile: name=$name, phone=$phone');

    final Map<String, dynamic> body = {};
    if (name != null) body['name'] = name;
    if (phone != null) body['phone'] = phone;
    final response = await _client.patch(
      ApiEndpoints.updateProfile,
      body,
    );
    debugPrint('Profile update response: $response');
    return response;
  }
  /// Upload avatar
  Future<Map<String, dynamic>> uploadAvatar(String imagePath) async {
    return await _client.patchMultipart(
      url: ApiEndpoints.updateAvatar,
      filePath: imagePath,
      fileField: 'avatar',
    );
  }
  /// Certificate
  Future<Map<String, dynamic>> fetchCertificate() async {
    return await _client.get(ApiEndpoints.certificate);
  }
  /// Contact Us
  Future<Map<String, dynamic>> contactUs(String message) async {
    return await _client.post(
      ApiEndpoints.contact,
      {
        "message": message,
      },
    );
  }
  /// Educate Employee
  Future<Map<String, dynamic>> educateEmployee({
    required String companyName,
    required int employeeCount,
    required String message,
  }) async {
    return await _client.post(
      ApiEndpoints.educateEmployee,
      {
        "company": companyName,
        "employeeCount": employeeCount,
        "message": message,
      },
    );
  }


  /// Course
  Future<Map<String, dynamic>> fetchCourses() async {
    return await _client.get(ApiEndpoints.courses);
  }
  /// Lessons via course id
  Future<Map<String, dynamic>> fetchCourseDetails(String courseId) async {
    return await _client.get("${ApiEndpoints.courses}/$courseId");
  }
  /// Next Video
  Future<Map<String, dynamic>> getNextVideo(String courseId) async {
    return await _client.get(
      "${ApiEndpoints.courses}/$courseId/next-video",
    );
  }
  /// Fetch reviews by lesson id
  Future<Map<String, dynamic>> fetchLessonReviews(String lessonId) async {
    return await _client.get(
      ApiEndpoints.review.replaceFirst(':id', lessonId),
    );
  }
  /// Create review
  Future<Map<String, dynamic>> createReview({required String lessonId, required int rating, required String comment}) async {
    return await _client.post(
      ApiEndpoints.review.replaceFirst(':id', lessonId),
      {
        "rating": rating,
        "comment": comment,
      },
    );
  }
  /// Fetch reviews by lesson id
  Future<Map<String, dynamic>> fetchLessonQuestions(String lessonId) async {
    return await _client.get(
      ApiEndpoints.questions.replaceFirst(':id', lessonId),
    );
  }



  /// Logout API (requires access token)
  Future<void> logout() async {
    await _client.post(ApiEndpoints.logout, {});
  }
}
