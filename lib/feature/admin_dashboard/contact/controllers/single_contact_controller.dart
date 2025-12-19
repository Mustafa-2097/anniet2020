import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/single_contact_model.dart';

class ContactDetailController extends GetxController {
  // Observables for Fetching
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var contactDetail = Rxn<SingleContactData>();

  // Observables for Replying
  var isReplying = false.obs;
  var isDeleting = false.obs;
  /// 1. Fetch contact detail by ID
  Future<void> fetchContactDetail(String id) async {
    try {
      isLoading.value = true;
      isError.value = false;
      contactDetail.value = null;

      final token = await SharedPreferencesHelper.getToken();
      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/contacts/$id');

      final response = await http.get(
        url,
        headers: {
          'Authorization': ?token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          contactDetail.value = SingleContactResponse.fromJson(jsonData).data;
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

  /// 2. Send Reply API
  Future<bool> sendReply(String id, String message) async {
    if (message.trim().isEmpty) {
      Get.snackbar("Error", "Message cannot be empty", snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    try {
      isReplying.value = true;
      final token = await SharedPreferencesHelper.getToken();
      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/contacts/$id/reply');

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
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            snackPosition: SnackPosition.BOTTOM);
        return true;
      } else {
        Get.snackbar("Error", jsonData['message'] ?? "Failed to send reply");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      return false;
    } finally {
      isReplying.value = false;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      isDeleting.value = true;
      final token = await SharedPreferencesHelper.getToken();
      final url = Uri.parse('${ApiEndpoints.baseUrl}/admin/contacts/$id');

      final response = await http.delete(url, headers: {
        'Authorization': ?token,
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Get.back(); // Go back to the list page
        Get.snackbar("Deleted", "Contact request removed successfully",
            backgroundColor: AppColors.primaryColor.withOpacity(0.1));
      } else {
        Get.snackbar("Error", "Failed to delete contact");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isDeleting.value = false;
    }
  }


  void _setError(String msg) {
    isError.value = true;
    errorMessage.value = msg;
  }
}