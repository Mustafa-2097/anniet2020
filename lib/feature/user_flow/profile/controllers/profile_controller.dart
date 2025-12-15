import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../auth/sign_in/controllers/sign_in_controller.dart';
import '../../../auth/sign_in/views/sign_in_page.dart';
import '../../data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final UserRepository _repository = UserRepository();

  /// States
  final isLoading = false.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userHandle = ''.obs;
  final avatarUrl = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  /// Load profile data
  Future<void> loadProfile() async {
    debugPrint('Loading profile...');
    try {
      isLoading.value = true;

      final data = await _repository.getProfile();
      debugPrint('Profile API response: $data');

      if(data['profile'] == null){
        throw Exception('Profile data missing');
      }

      final fullName = data['profile']?['name'] ?? '';
      userName.value = fullName;
      userEmail.value = data['email'] ?? '';
      avatarUrl.value = data['profile']?['avatar'];

      /// @firstWord logic
      userHandle.value = generateHandle(fullName);
    } catch (e, s) {
      debugPrint('Error loading profile: $e');
      debugPrint('Stack trace: $s');
      Get.snackbar('Error', e.toString(), backgroundColor: AppColors.redColor);
    } finally {
      isLoading.value = false;
    }
  }

  /// Generate @firstWord
  String generateHandle(String name) {
    if (name.trim().isEmpty) return '';
    final firstWord = name.trim().split(' ').first;
    return '@${firstWord.toLowerCase()}';
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _repository.logout();
      Get.delete<ProfileController>(force: true);
      Get.delete<SignInController>(force: true);
      Get.offAll(() => SignInPage());
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString());
    }
  }
}
