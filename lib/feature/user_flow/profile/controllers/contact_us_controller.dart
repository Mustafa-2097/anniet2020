import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ContactUsController extends GetxController {
  static ContactUsController get instance => Get.find();

  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final messageController = TextEditingController();

  /// Dropdown value
  var employeeCount = "1-10".obs;

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

  /// Company validation
  String? validateCompany(String value) {
    if (value.isEmpty) return "Company name is required";
    return null;
  }

  /// Message validation
  String? validateMessage(String value) {
    if (value.isEmpty) return "Message is required";
    if (value.length < 10) return "Message must be at least 10 characters";
    return null;
  }

  /// Full phone with country code
  String get fullPhone => "$countryCode${phoneController.text.trim()}";

  /// Submit logic
  Future<void> contactChange(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;
    EasyLoading.show(status: 'Sending...');
    await Future.delayed(const Duration(seconds: 2));
    EasyLoading.dismiss();
    Get.snackbar("Success", "Your message has been sent!", snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
