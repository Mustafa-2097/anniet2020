import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  // Prevent multiple picker calls
  var isPickingImage = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
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
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );
        // Clear fields after success
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Something went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
            data['message'] ?? "Profile updated successfully",
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
          );
          // Refetch profile to update the UI
          await fetchProfile();
        } else {
          Get.snackbar(
            "Error",
            data['message'] ?? "Failed to update profile",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Something went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Compress image to reduce file size
  Future<File?> _compressImage(File imageFile) async {
    try {
      final filePath = imageFile.path;

      // Get file size in MB
      final fileSize = await imageFile.length() / (1024 * 1024);

      // If file is already small (< 1MB), don't compress
      if (fileSize < 1) {
        return imageFile;
      }

      // Create compressed file path
      final directory = await getTemporaryDirectory();
      final targetPath = '${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Compress image
      final result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        targetPath,
        quality: 50, // Reduce quality to 85%
      );

      if (result == null) {
        return imageFile;
      }

      return File(result.path);
    } catch (e) {
      print("Compression error: $e");
      return imageFile; // Return original if compression fails
    }
  }

  Future<void> updateAvatar(File imageFile) async {
    try {
      isLoading.value = true;

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) return;

      // Compress image before upload
      final compressedFile = await _compressImage(imageFile);
      final fileToUpload = compressedFile ?? imageFile;

      // Check file size after compression
      final fileSize = await fileToUpload.length() / (1024 * 1024);
      if (fileSize > 2) { // Limit to 2MB
        Get.snackbar(
          "Error",
          "Image size is too large (${fileSize.toStringAsFixed(2)}MB). Please select a smaller image.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final uri = Uri.parse('${ApiEndpoints.baseUrl}/me/avatar');
      final request = http.MultipartRequest('PATCH', uri);

      request.headers['Authorization'] = token;

      final extension = path.extension(fileToUpload.path).toLowerCase();

      MediaType mediaType;
      if (extension == '.png') {
        mediaType = MediaType('image', 'png');
      } else if (extension == '.jpg' || extension == '.jpeg') {
        mediaType = MediaType('image', 'jpeg');
      } else {
        Get.snackbar(
          "Error",
          "Unsupported image format",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          fileToUpload.path,
          contentType: mediaType,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Check if response is HTML (error)
      if (response.headers['content-type']?.contains('text/html') ?? false) {
        throw Exception("Server error: ${response.body}");
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Avatar updated successfully",
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );
        await fetchProfile();
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Failed to update avatar",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Avatar update error: $e");
      Get.snackbar(
        "Error",
        e.toString().contains("413")
            ? "Image size is too large. Please select a smaller image."
            : e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    // Prevent multiple clicks
    if (isPickingImage.value) return;

    isPickingImage.value = true;

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Already compressed by picker
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        final ext = pickedFile.path.toLowerCase();
        if (!(ext.endsWith('.jpg') ||
            ext.endsWith('.jpeg') ||
            ext.endsWith('.png'))) {
          Get.snackbar(
            "Error",
            "Please select a JPG or PNG image",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      print("Image pick error: $e");
      Get.snackbar(
        "Error",
        "Failed to pick image",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // Add small delay before allowing next pick
      await Future.delayed(Duration(milliseconds: 500));
      isPickingImage.value = false;
    }
  }

  Future<void> saveProfile() async {
    try {
      isLoading.value = true;

      // Validate name
      if (nameController.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Name cannot be empty",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Update profile info
      await updateProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
      );

      // Update avatar if image was selected
      if (selectedImage.value != null) {
        await updateAvatar(selectedImage.value!);
      }

      Get.back();
    } catch (e) {
      print("Save profile error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}