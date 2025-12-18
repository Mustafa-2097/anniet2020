import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';

class UserSuspendController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isSuccess = false.obs;

  /// Suspend user by ID
  Future<void> suspendUser(String userId) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';
      isSuccess.value = false;

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/users/$userId/suspend');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        isSuccess.value = true; // successfully suspended
      } else {
        _setError('Failed to suspend user: ${response.statusCode}');
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
