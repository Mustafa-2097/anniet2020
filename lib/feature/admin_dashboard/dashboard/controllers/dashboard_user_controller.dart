import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/dashboard_user_model.dart';

class DashboardUserController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var users = <UserData>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Initial fetch
  }

  Future<void> goToPage(int page) async {
    if (page != currentPage.value) {
      await fetchUsers(page: page);
    }
  }

  Future<void> goNextPage() async => loadNextPage();

  Future<void> goPreviousPage() async {
    if (currentPage.value > 1) {
      await fetchUsers(page: currentPage.value - 1);
    }
  }

  // Fetch users
  Future<void> fetchUsers({int page = 1, int limit = 10}) async {
    // try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/users?page=$page&limit=$limit');
      final response = await http.get(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      print(response.request?.url);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] != true) {
          _setError(jsonData['message'] ?? 'Failed to fetch users');
          return;
        }

        final data = UsersResponse.fromJson(jsonData);

        // Append if loading next page
        if (page > 1) {
          users.addAll(data.data);
        } else {
          users.value = data.data;
        }

        currentPage.value = data.pagination.page;
        totalPages.value = data.pagination.totalPage;
      } else {
        _setError('Failed to fetch users: ${response.statusCode}');
      }
    // } catch (e) {
    //   _setError('Something went wrong: $e');
    // } finally {
    //   isLoading.value = false;
    // }
  }

  // Load next page for pagination
  Future<void> loadNextPage() async {
    if (currentPage.value < totalPages.value) {
      await fetchUsers(page: currentPage.value + 1);
    }
  }

  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
  }
}
