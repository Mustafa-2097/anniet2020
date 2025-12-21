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
  final messageController = TextEditingController();

  /// Dropdown value
  var employeeCount = "1-10".obs;

  /// Convert dropdown value to int
  int _mapEmployeeCount(String value) {
    switch (value) {
      case "1-10":
        return 10;
      case "11-50":
        return 50;
      case "51-200":
        return 200;
      case "200+":
        return 201;
      default:
        return 0;
    }
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

  /// logic
  Future<void> educateEmployee(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    try {
      EasyLoading.show(status: 'Sending...');

      await _repository.educateEmployee(
        companyName: companyController.text.trim(),
        employeeCount: _mapEmployeeCount(employeeCount.value),
        message: messageController.text.trim(),
      );

      EasyLoading.dismiss();

      Get.snackbar("Success", "Your request has been sent successfully!", backgroundColor: AppColors.primaryColor, snackPosition: SnackPosition.BOTTOM);
      companyController.clear();
      messageController.clear();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
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
    messageController.dispose();
    super.onClose();
  }
}
