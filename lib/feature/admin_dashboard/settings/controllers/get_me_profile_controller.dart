import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/get_me_model.dart';

class AdminProfileController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var profile = Rxn<AdminData>();

  // Fetch admin profile
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/me/profile');
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
          _setError(jsonData['message'] ?? 'Failed to fetch profile');
          return;
        }

        final data = AdminProfileResponse.fromJson(jsonData);
        profile.value = data.data;
      } else {
        _setError('Failed to fetch profile: ${response.statusCode}');
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
