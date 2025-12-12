import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  /// USER PROFILE DATA
  var fullName = "John Emily Carter".obs;
  var phone = "+84 0373467950".obs;
  var email = "giangbanganh@gmail.com".obs;

  /// PROFILE IMAGE
  var profileImagePath = "".obs;

  /// PASSWORD FIELDS
  var currentPassword = "".obs;
  var newPassword = "".obs;
  var confirmNewPassword = "".obs;

  /// PASSWORD VISIBILITY
  var showCurrentPassword = false.obs;
  var showNewPassword = false.obs;
  var showConfirmPassword = false.obs;

  // Toggle Function
  void togglePassword(int index) {
    if (index == 1) {
      showCurrentPassword.value = !showCurrentPassword.value;
    } else if (index == 2) {
      showNewPassword.value = !showNewPassword.value;
    } else if (index == 3) {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }

  /// -------------------------------
  /// UPDATE PROFILE FROM EDIT PAGE
  /// -------------------------------
  void updateProfile({
    required String name,
    required String phoneNumber,
    required String emailAddress,
    String? imagePath,
  }) {
    fullName.value = name;
    phone.value = phoneNumber;
    email.value = emailAddress;

    if (imagePath != null) {
      profileImagePath.value = imagePath;
    }
  }

  /// -------------------------------
  /// CHANGE PASSWORD LOGIC
  /// -------------------------------
  void changePassword() {
    if (newPassword.value != confirmNewPassword.value) {
      Get.snackbar("Error", "New passwords do not match!");
      return;
    }
    Get.snackbar("Success", "Password updated successfully!");
  }
}
