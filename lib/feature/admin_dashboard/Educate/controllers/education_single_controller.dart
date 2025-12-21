import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constant/app_colors.dart';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/education_single_model.dart';

class EducationSingleController extends GetxController {
  /// Fetching state
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  /// Detail data
  var educateDetail = Rxn<SingleContactData>();

  // Observables for Replying
  var isReplying = false.obs;
  var isDeleting = false.obs;

  /// Fetch Educate Employee detail by ID
  Future<void> fetchEducateEmployeeDetail(String id) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';
      educateDetail.value = null;

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Authentication failed. Please login again.");
        return;
      }

      final url = Uri.parse(
        '${ApiEndpoints.baseUrl}/admin/educate-employee/$id',
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
          educateDetail.value =
              SingleContactResponse.fromJson(jsonData).data;
        } else {
          _setError(jsonData['message'] ?? 'Failed to load details');
        }
      } else {
        _setError('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      _setError('Connection error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> sendReply(String id, String message) async {
    if (message.trim().isEmpty) {
      Get.snackbar("Error", "Message cannot be empty", backgroundColor: AppColors.primaryColor, snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    try {
      isReplying.value = true;
      final token = await SharedPreferencesHelper.getToken();
      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/educate-employee/$id/reply');

      final response = await http.post(
        url,
        headers: {
          'Authorization': ?token,
          'Content-Type': 'application/json',
        },
        body: json.encode({"message": message}),
      );

      final jsonData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Reply sent successfully",
            backgroundColor: AppColors.primaryColor,
            snackPosition: SnackPosition.BOTTOM);
        return true;
      } else {
        Get.snackbar("Error", jsonData['message'] ?? "Failed to send reply", backgroundColor: AppColors.primaryColor);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e", backgroundColor: AppColors.primaryColor);
      return false;
    } finally {
      isReplying.value = false;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      isDeleting.value = true;
      final token = await SharedPreferencesHelper.getToken();
      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/educate-employee/$id');

      final response = await http.delete(url, headers: {
        'Authorization': ?token,
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Get.back(); // Go back to the list page
        Get.snackbar("Deleted", "Contact request removed successfully",
            backgroundColor: AppColors.primaryColor);
      } else {
        Get.snackbar("Error", "Failed to delete contact", backgroundColor: AppColors.primaryColor);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e", backgroundColor: AppColors.primaryColor);
    } finally {
      isDeleting.value = false;
    }
  }

  /// Common error handler
  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
    Get.snackbar(
      "Error",
      backgroundColor: AppColors.primaryColor,
      msg,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
