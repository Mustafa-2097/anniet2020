import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/educated_model.dart';

class EducateEmployeeController extends GetxController {
  /// UI State
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  /// Data
  var employeeList = <EducateEmployeeData>[].obs;

  /// Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEducateEmployees();
  }

  /// Fetch Educate Employees (Paginated)
  Future<void> fetchEducateEmployees({int page = 1, int limit = 10}) async {
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
        '${ApiEndpoints.baseUrl}/admin/educate-employee?page=$page&limit=$limit',
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
          final educateEmployeeResponse =
          EducateEmployeeResponse.fromJson(jsonData);

          employeeList.assignAll(educateEmployeeResponse.data);
          currentPage.value = educateEmployeeResponse.pagination.page;
          totalPages.value = educateEmployeeResponse.pagination.totalPage;
        } else {
          _setError(jsonData['message'] ?? 'Failed to load data');
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
      await fetchEducateEmployees(page: page);
    }
  }

  Future<void> goNextPage() async {
    if (currentPage.value < totalPages.value) {
      await fetchEducateEmployees(page: currentPage.value + 1);
    }
  }

  Future<void> goPreviousPage() async {
    if (currentPage.value > 1) {
      await fetchEducateEmployees(page: currentPage.value - 1);
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
