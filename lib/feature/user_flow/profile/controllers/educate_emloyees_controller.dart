import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EducateEmployeesController extends GetxController {
  static EducateEmployeesController get instance => Get.find();
  final profile = ProfileController.instance;

  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final messageController = TextEditingController();

  /// Dropdown value
  var employeeCount = "1-10".obs;

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

  /// Submit logic
  Future<void> contactChange(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;
    EasyLoading.show(status: 'Sending...');
    await Future.delayed(const Duration(seconds: 2));
    EasyLoading.dismiss();
    Get.snackbar("Success", "Your message has been sent!", snackPosition: SnackPosition.BOTTOM);
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
    companyController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
