import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/dashboard_review_model.dart';

class DashboardReviewController extends GetxController {
  /// UI State
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  /// Data
  var reviews = <CourseReview>[].obs;
  var averageRating = 0.0.obs;
  var ratingCounts = <int, int>{}.obs;

  /// Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  var selectedFilter = 0.obs;


  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  List<CourseReview> get filteredReviews {
    if (selectedFilter.value == 0) return reviews;
    return reviews.where((r) => r.rating == selectedFilter.value).toList();
  }

  double getProgress(int star) {
    if (reviews.isEmpty) return 0.0;
    final count = ratingCounts[star] ?? 0;
    return count / reviews.length;
  }

  /// Fetch Reviews (Paginated)
  Future<void> fetchReviews({int page = 1, int limit = 10}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Authentication failed. Please login again.");
        return;
      }

      final url = Uri.parse(
        '${ApiEndpoints.baseUrl}/admin/reviews?page=$page&limit=$limit',
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true) {
          final reviewResponse = CourseReviewsResponse.fromJson(jsonData);

          /// List data
          reviews.assignAll(reviewResponse.data.reviews);

          /// Summary data
          averageRating.value = reviewResponse.data.average;
          ratingCounts.value = reviewResponse.data.counts;

          /// Pagination
          currentPage.value = reviewResponse.pagination.page;
          totalPages.value = reviewResponse.pagination.totalPage;
        } else {
          _setError(jsonData['message'] ?? 'Failed to load reviews');
        }
      } else {
        _setError('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      _setError('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Pagination Helpers
  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      await fetchReviews(page: page);
    }
  }

  Future<void> goNextPage() async {
    if (currentPage.value < totalPages.value) {
      await fetchReviews(page: currentPage.value + 1);
    }
  }

  Future<void> goPreviousPage() async {
    if (currentPage.value > 1) {
      await fetchReviews(page: currentPage.value - 1);
    }
  }

  /// Error Handler
  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
    Get.snackbar(
      "Error",
      msg,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
