import 'package:anniet2020/feature/user_flow/dashboard/customer_dashboard.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../data/repositories/user_repository.dart';

class PersonalInfoController extends GetxController {
  static PersonalInfoController get instance => Get.find();
  final profile = ProfileController.instance;
  final UserRepository _repository = UserRepository();
  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  /// Fixed Country Code (Australia)
  final String countryCode = "+61";

  /// Name Validation
  String? validateName(String value) {
    if (value.isEmpty) return "Please enter your full name";
    if (value.length < 3) return "Name must be at least 3 characters";
    return null;
  }

  // /// Email Validation no need for update page
  // String? validateEmail(String value) {
  //   if (value.isEmpty) return "Email is required";
  //   if (!GetUtils.isEmail(value)) return "Enter a valid email";
  //   return null;
  // }

  /// Phone Validation
  String? validatePhone(String value) {
    if (value.isEmpty) return null;
    if (value.length < 7) return "Enter a valid phone number";
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
    if (nameController.text.trim() == profile.userName.value && fullPhone == null) {
      Get.snackbar("Info", "No changes to save", backgroundColor: Colors.orange, colorText: Colors.white);
      return; // Exit without calling API
    }

    try {
      EasyLoading.show(status: 'Saving info...');
      await _repository.updateProfile(
        name: nameController.text.trim(),
        phone: fullPhone,
      );

      // update ProfileController state
      final profile = ProfileController.instance;
      profile.userName.value = nameController.text.trim();
      profile.userHandle.value = profile.generateHandle(nameController.text.trim());
      // phone thakle set koro, jodi ProfileController e phone thake
      // profile.userPhone.value = fullPhone ?? profile.userPhone.value;

      EasyLoading.dismiss();
      Get.snackbar("Success", "Profile updated successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Get.off(() => CustomerDashboard(initialIndex: 3));
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Update Failed", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = profile.userName.value;
    emailController.text = profile.userEmail.value;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
