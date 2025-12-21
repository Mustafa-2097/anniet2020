import 'dart:io';

import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../../../core/offline_storage/shared_pref.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/get_me_model.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class AdminProfileController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var profile = Rxn<UserData>();

  // Password fields
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var showOldPassword = false.obs;
  var showNewPassword = false.obs;
  var showConfirmPassword = false.obs;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  var selectedImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    if (profile.value != null) {
      nameController.text = profile.value!.profile.name;
      phoneController.text = profile.value!.profile.phone;
      emailController.text = profile.value!.email;
    }
  }

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
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] != true) {
          _setError(jsonData['message'] ?? 'Failed to fetch profile');
          return;
        }

        final data = ProfileResponse.fromJson(jsonData);
        profile.value = data.data;

        nameController.text = profile.value!.profile.name;
        phoneController.text = profile.value!.profile.phone;
        emailController.text = profile.value!.email;

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


  void togglePassword(int fieldIndex) {
    if (fieldIndex == 1) {
      showOldPassword.value = !showOldPassword.value;
    } else if (fieldIndex == 2) {
      showNewPassword.value = !showNewPassword.value;
    } else if (fieldIndex == 3) {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final response = await http.put(
        Uri.parse('${ApiEndpoints.baseUrl}/auth/change-password'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
        body: jsonEncode({
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          data['message'] ?? "Password changed successfully",
        );
        // Clear fields after success
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      isLoading.value = true;

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        _setError("Session expired. No token found");
        return;
      }

      final response = await http.patch(
        Uri.parse('${ApiEndpoints.baseUrl}/me/profile'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          Get.snackbar(
            "Success",
            data['message'] ?? "Profile updated successfully", backgroundColor: AppColors.primaryColor
          );
          // Refetch profile to update the UI
          await fetchProfile();
        } else {
          Get.snackbar(
            "Error",
            data['message'] ?? "Failed to update profile",
          );
        }
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> updateAvatar(File imageFile) async {
    try {
      isLoading.value = true;

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) return;

      final uri = Uri.parse('${ApiEndpoints.baseUrl}/me/avatar');
      final request = http.MultipartRequest('PATCH', uri);

      request.headers['Authorization'] = token;

      final extension = path.extension(imageFile.path).toLowerCase();

      MediaType mediaType;
      if (extension == '.png') {
        mediaType = MediaType('image', 'png');
      } else if (extension == '.jpg' || extension == '.jpeg') {
        mediaType = MediaType('image', 'jpeg');
      } else {
        Get.snackbar("Error", "Unsupported image format");
        return;
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          imageFile.path,
          contentType: mediaType,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print(response.body);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Get.snackbar("Success", data['message']);
        print("successfully insert the avater");
        await fetchProfile();
      } else {
        Get.snackbar("Error", data['message']);
      }
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile != null) {
      final ext = pickedFile.path.toLowerCase();
      if (!(ext.endsWith('.jpg') || ext.endsWith('.jpeg') || ext.endsWith('.png'))) {
        Get.snackbar("Error", "Please select a JPG or PNG image");
        return;
      }

      selectedImage.value = File(pickedFile.path);
    }
  }


  Future<void> saveProfile() async {
    await updateProfile(
      name: nameController.text,
      phone: phoneController.text,
    );

    if (selectedImage.value != null) {
      await updateAvatar(selectedImage.value!);
    }

    Get.back();
  }






}
