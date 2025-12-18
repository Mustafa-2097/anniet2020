import 'package:anniet2020/core/network/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../models/dashboard_review_model.dart';

class DashboardReviewController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var reviews = <Review>[].obs;
  var averageRating = 0.0.obs;
  var counts = <String, int>{}.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  final isError = false.obs;
  final errorMessage = ''.obs;

  // Fetch reviews
  Future<void> fetchReviews({int page = 1, int limit = 10}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/reviews?page=$page&limit=$limit');
      final response = await http.get(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] != true) {
          _setError(jsonData['message'] ?? 'Failed to fetch reviews');
          return;
        }

        final data = CourseReviewResponse.fromJson(jsonData);

        // Append if loading next page
        if (page > 1) {
          reviews.addAll(data.data.reviews);
        } else {
          reviews.value = data.data.reviews;
        }

        averageRating.value = data.data.average;
        counts.value = data.data.counts;
        currentPage.value = data.pagination.page;
        totalPages.value = data.pagination.totalPage;
      } else {
        _setError('Failed to fetch reviews: ${response.statusCode}');
      }
    } catch (e) {
      _setError('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Optional: Load next page
  Future<void> loadNextPage() async {
    if (currentPage.value < totalPages.value) {
      await fetchReviews(page: currentPage.value + 1);
    }
  }

  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
  }

}
