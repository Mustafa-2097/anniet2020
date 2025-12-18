import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/dashboard_payment_model.dart';

class PaymentsController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var payments = <PaymentData>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  // Fetch payments
  Future<void> fetchPayments({int page = 1, int limit = 10}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/payments?page=$page&limit=$limit');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] != true) {
          _setError(jsonData['message'] ?? 'Failed to fetch payments');
          return;
        }

        final data = PaymentsResponse.fromJson(jsonData);

        // Append if loading next page
        if (page > 1) {
          payments.addAll(data.data);
        } else {
          payments.value = data.data;
        }

        currentPage.value = data.pagination.page;
        totalPages.value = data.pagination.totalPage;
      } else {
        _setError('Failed to fetch payments: ${response.statusCode}');
      }
    } catch (e) {
      _setError('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load next page for pagination
  Future<void> loadNextPage() async {
    if (currentPage.value < totalPages.value) {
      await fetchPayments(page: currentPage.value + 1);
    }
  }

  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
  }
}
