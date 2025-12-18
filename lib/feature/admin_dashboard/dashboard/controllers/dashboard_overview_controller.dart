import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/dashboard_overview_model.dart';

class AnalyticsController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var totalRevenue = 0.obs;
  var totalUsers = 0.obs;
  var totalSell = 0.obs;
  var totalCompleted = 0.obs;

  // Fetch analytics data
  Future<void> fetchAnalytics() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/analytics');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // usually Bearer token
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] != true) {
          _setError(jsonData['message'] ?? 'Failed to fetch analytics');
          return;
        }

        final data = AnalyticsResponse.fromJson(jsonData);

        totalRevenue.value = data.data.data.totalRevenue;
        totalUsers.value = data.data.data.totalUsers;
        totalSell.value = data.data.data.totalSell;
        totalCompleted.value = data.data.data.totalCompleted;
      } else {
        _setError('Failed to fetch analytics: ${response.statusCode}');
      }
    } catch (e) {
      _setError('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
  }
}
