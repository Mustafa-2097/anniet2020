import 'package:anniet2020/feature/user_flow/dashboard/customer_dashboard.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repositories/user_repository.dart';

class PersonalInfoController extends GetxController {
  static PersonalInfoController get instance => Get.find();
  final profile = Get.find<ProfileController>();

  var fullName = "Your full name".obs;
  var email = "Your email".obs;
  var phone = "Phone".obs;

  var pickedImage = Rx<XFile?>(null);

  final ImagePicker picker = ImagePicker();
  final previewImagePath = RxnString();

  Future pickImage() async {
    final img = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (img == null) return;
    final ext = img.path.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png'].contains(ext)) {
      Get.snackbar("Invalid image", "Only JPG, JPEG, PNG images are allowed", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    pickedImage.value = img;
    previewImagePath.value = img.path;
  }

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
    final bool isNameChanged = nameController.text.trim() != profile.userName.value;
    final bool isPhoneChanged = fullPhone != null && fullPhone != profile.userPhone.value;
    final bool isImageChanged = pickedImage.value != null;
    if (!isNameChanged && !isPhoneChanged && !isImageChanged) {
      Get.snackbar("Info", "No changes to save", backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    try {
      EasyLoading.show(status: 'Saving info...');
      if (isNameChanged || isPhoneChanged) {
        await _repository.updateProfile(
          name: isNameChanged ? nameController.text.trim() : null,
          phone: isPhoneChanged ? fullPhone : null,
        );
      }
      if (isImageChanged) {
        final avatarUrl = await _repository.uploadAvatar(pickedImage.value!.path);
        profile.avatarUrl.value = avatarUrl;
      }
      if (isNameChanged) {
        profile.userName.value = nameController.text.trim();
        profile.userHandle.value = profile.generateHandle(nameController.text.trim());
      }
      if (isPhoneChanged) profile.userPhone.value = fullPhone!;
      EasyLoading.dismiss();
      Get.snackbar("Success", "Profile updated successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Get.off(() => CustomerDashboard(initialIndex: 3));
    } catch (e, stack) {
      EasyLoading.dismiss();
      debugPrint('❌ PROFILE UPDATE ERROR');
      debugPrint(e.toString());
      debugPrint(stack.toString());
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
