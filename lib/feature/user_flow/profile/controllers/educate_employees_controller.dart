import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../data/repositories/user_repository.dart';

class EducateEmployeesController extends GetxController {
  static EducateEmployeesController get instance => Get.find();
  final profile = Get.find<ProfileController>();
  final UserRepository _repository = UserRepository();

  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final employeeController = TextEditingController();
  final messageController = TextEditingController();

  /// Company validation
  String? validateCompany(String value) {
    if (value.isEmpty) return "Company name is required";
    return null;
  }

  /// How many Employees validation
  String? validateEmployees(String value) {
    if (value.isEmpty) return "Employee count is required";
    return null;
  }

  /// Message validation
  String? validateMessage(String value) {
    if (value.isEmpty) return "Message is required";
    if (value.length < 10) return "Message must be at least 10 characters";
    return null;
  }

  /// Educate Employee
  Future<void> educateEmployee(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    try {
      EasyLoading.show(status: 'Sending...');

      await _repository.educateEmployee(
        companyName: companyController.text.trim(),
        employeeCount:  int.tryParse(employeeController.text.trim()) ?? 0,
        message: messageController.text.trim(),
      );

      EasyLoading.dismiss();
      Get.snackbar("Success", "Your request has been sent successfully!", backgroundColor: AppColors.primaryColor);
      companyController.clear();
      employeeController.clear();
      messageController.clear();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString(), backgroundColor: AppColors.redColor);
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
    companyController.dispose();
    employeeController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
