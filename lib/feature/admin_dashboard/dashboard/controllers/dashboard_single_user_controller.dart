import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/dashboard_single_user_model.dart';

class DashboardSingleUserController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var userDetail = Rxn<UserDetail>();

  // Fetch single user detail by ID
  Future<void> fetchUserDetail(String id) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/users/$id');
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
          _setError(jsonData['message'] ?? 'Failed to fetch user');
          return;
        }

        final data = UserDetailResponse.fromJson(jsonData);
        userDetail.value = data.data;
      } else {
        _setError('Failed to fetch user: ${response.statusCode}');
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
