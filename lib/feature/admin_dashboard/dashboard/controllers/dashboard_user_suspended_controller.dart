import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';

class DashboardUserSuspendedController extends GetxController {
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
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        isSuccess.value = true;

        // Success Feedback
        Get.snackbar(
          "Success",
          responseData['message'] ?? "User suspended successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      } else {
        _setError(responseData['message'] ?? 'Failed to suspend user');
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

    // Error Feedback
    Get.snackbar(
      "Action Failed",
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
    );
  }
}