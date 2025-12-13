import 'package:get/get.dart';
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
    try {
      isLoading.value = true;

      final data = await _repository.getProfile();

      final fullName = data['profile']?['name'] ?? '';

      userName.value = fullName;
      userEmail.value = data['email'] ?? '';
      avatarUrl.value = data['profile']?['avatar'];

      /// @firstWord logic
      userHandle.value = _generateHandle(fullName);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Generate @firstWord
  String _generateHandle(String name) {
    if (name.trim().isEmpty) return '';
    final firstWord = name.trim().split(' ').first;
    return '@${firstWord.toLowerCase()}';
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _repository.logout();
      Get.offAll(() => SignInPage());
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString());
    }
  }
}
