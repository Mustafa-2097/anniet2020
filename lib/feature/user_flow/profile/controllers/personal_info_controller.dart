import 'package:anniet2020/feature/user_flow/dashboard/customer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PersonalInfoController extends GetxController {
  static PersonalInfoController get instance => Get.find();

  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  /// Fixed Country Code (Australia)
  final String countryCode = "+61";

  /// Name Validation
  String? validateName(String value) {
    if (value.isEmpty) return "Full Name is required";
    if (value.length < 3) return "Name must be at least 3 characters";
    return null;
  }

  /// Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!GetUtils.isEmail(value)) return "Enter a valid email";
    return null;
  }

  /// Phone Validation
  String? validatePhone(String value) {
    if (value.isEmpty) return "Phone number is required";
    if (value.length < 7) return "Enter a valid phone number";
    return null;
  }

  /// Full phone with country code
  String get fullPhone => "$countryCode${phoneController.text.trim()}";

  /// Save / Update Logic
  Future<void> infoChange(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    EasyLoading.show(status: 'Saving info...');

    await Future.delayed(const Duration(seconds: 2));

    EasyLoading.dismiss();
    Get.to(() => CustomerDashboard(initialIndex: 3));

  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
