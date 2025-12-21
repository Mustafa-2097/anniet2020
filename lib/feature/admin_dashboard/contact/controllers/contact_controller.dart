import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/offline_storage/shared_pref.dart'; // Adjust path
import '../../../../core/network/api_endpoints.dart';     // Adjust path
import '../model/contact_model.dart';                     // Adjust path

class ContactController extends GetxController {
  // Observables for UI states
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // Data observables
  var contactList = <ContactData>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts(); // Auto-load data when controller is initialized
  }

  /// Fetch Contacts with Pagination
  Future<void> fetchContacts({int page = 1, int limit = 10, String? searchTerm}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      // Get token from storage
      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Authentication failed. Please log in again.");
        return;
      }

      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),

        if(searchTerm != null && searchTerm.isNotEmpty)
          'searchTerm': searchTerm,
      };

      // Construct URL
      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/contacts?page=$page&limit=$limit').replace(
        queryParameters: queryParams
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
          final contactResponse = ContactResponse.fromJson(jsonData);

          // Update pagination and data
          // Using assignAll to refresh the list for the specific page
          contactList.assignAll(contactResponse.data);
          currentPage.value = contactResponse.pagination.page;
          totalPages.value = contactResponse.pagination.totalPage;
        } else {
          _setError(jsonData['message'] ?? 'Failed to retrieve contacts');
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

  /// Navigation helpers for Pagination UI
  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      await fetchContacts(page: page);
    }
  }

  Future<void> goNextPage() async {
    if (currentPage.value < totalPages.value) {
      await fetchContacts(page: currentPage.value + 1);
    }
  }

  Future<void> goPreviousPage() async {
    if (currentPage.value > 1) {
      await fetchContacts(page: currentPage.value - 1);
    }
  }

  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
    // Optional: Show a snackbar on error
    Get.snackbar("Error",backgroundColor: AppColors.primaryColor, msg, snackPosition: SnackPosition.BOTTOM);
  }
}