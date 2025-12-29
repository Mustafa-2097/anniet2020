import 'dart:io';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constant/app_colors.dart';
import '../../data/repositories/user_repository.dart';

class PersonalInfoController extends GetxController {
  static PersonalInfoController get instance => Get.find();
  final profile = Get.find<ProfileController>();

  final ImagePicker picker = ImagePicker();
  final previewImagePath = RxnString();

  // Prevent multiple image picker calls
  var isPickingImage = false.obs;

  final UserRepository _repository = UserRepository();

  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  /// Fixed Country Code (Australia)
  final String countryCode = "+61";

  Future<void> pickImage() async {
    // Prevent multiple simultaneous picker calls
    if (isPickingImage.value) return;

    try {
      isPickingImage.value = true;

      final img = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Reduced quality to reduce file size
      );

      if (img == null) {
        isPickingImage.value = false;
        return;
      }

      // Validate file size BEFORE processing
      final file = File(img.path);
      final fileSize = await file.length();
      const maxSize = 2 * 1024 * 1024; // 2MB max size

      if (fileSize > maxSize) {
        Get.snackbar(
          "File too large",
          "Image must be less than 2MB. Current size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB",
          backgroundColor: AppColors.redColor,
        );
        isPickingImage.value = false;
        return;
      }

      // Validate extension
      final ext = img.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png'].contains(ext)) {
        Get.snackbar(
          "Invalid image",
          "Only JPG, JPEG, PNG images are allowed",
          backgroundColor: AppColors.redColor,
        );
        isPickingImage.value = false;
        return;
      }

      // Set the preview image path
      previewImagePath.value = img.path;

    } catch (e) {
      debugPrint('Image picker error: $e');
      Get.snackbar(
        "Error",
        "Failed to pick image. Please try again.",
        backgroundColor: AppColors.redColor,
      );
    } finally {
      isPickingImage.value = false;
    }
  }

  /// Name Validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Please enter your full name";
    if (value.trim().length < 3) return "Name must be at least 3 characters";
    return null;
  }

  /// Phone Validation
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.trim().length < 7) return "Enter a valid phone number";
    return null;
  }

  /// Full phone with country code
  String? get fullPhone {
    if (phoneController.text.trim().isEmpty) return null;
    return "$countryCode${phoneController.text.trim()}";
  }

  /// Save / Update Logic
  Future<void> infoChange(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    // Check if nothing changed
    final bool isNameChanged = nameController.text.trim() != profile.userName.value;
    final bool isPhoneChanged = fullPhone != null && fullPhone != profile.userPhone.value;
    final bool isImageChanged = previewImagePath.value != null;

    if (!isNameChanged && !isPhoneChanged && !isImageChanged) {
      Get.snackbar(
        "Info",
        "No changes to save",
        backgroundColor: Colors.orange,
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Saving info...');

      // Update profile info if changed
      if (isNameChanged || isPhoneChanged) {
        await _repository.updateProfile(
          name: isNameChanged ? nameController.text.trim() : null,
          phone: isPhoneChanged ? fullPhone : null,
        );
      }

      // Upload avatar if changed
      if (isImageChanged) {
        try {
          final avatarUrl = await _repository.uploadAvatar(previewImagePath.value!);
          profile.avatarUrl.value = avatarUrl;
        } catch (e) {
          debugPrint('Avatar upload failed: $e');
          // Don't fail entire update if avatar upload fails
          Get.snackbar(
            "Note",
            "Profile updated but avatar failed to upload. Try a smaller image.",
            backgroundColor: Colors.orange,
          );
        }
      }

      // Update local state
      if (isNameChanged) {
        profile.userName.value = nameController.text.trim();
        profile.userHandle.value = profile.generateHandle(nameController.text.trim());
      }
      if (isPhoneChanged) profile.userPhone.value = fullPhone!;

      EasyLoading.dismiss();

      Get.snackbar(
        "Success",
        "Profile updated successfully",
        backgroundColor: AppColors.primaryColor,
      );

      // Navigate back after a delay
      await Future.delayed(Duration(milliseconds: 1500));
      Get.back();

    } catch (e, stack) {
      EasyLoading.dismiss();
      debugPrint('❌ PROFILE UPDATE ERROR');
      debugPrint(e.toString());
      debugPrint(stack.toString());
      Get.snackbar(
        "Update Failed",
        "Failed to update profile. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = profile.userName.value;
    emailController.text = profile.userEmail.value;
    phoneController.text = profile.userPhone.value?.replaceFirst('+61', '') ?? '';
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    isPickingImage.value = false;
    super.onClose();
  }
}
