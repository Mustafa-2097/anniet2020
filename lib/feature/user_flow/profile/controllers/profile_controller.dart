import 'package:anniet2020/feature/user_flow/profile/controllers/personal_info_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../auth/sign_in/controllers/sign_in_controller.dart';
import '../../../auth/sign_in/views/sign_in_page.dart';
import '../../data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final UserRepository _repository = UserRepository();

  /// Profile states
  final isLoading = false.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userHandle = ''.obs;
  final userPhone = RxnString();
  final avatarUrl = RxnString();
  final introVideoUrl = RxnString();

  /// Video states (same as OnlineClassController)
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  final isInitialized = false.obs;
  String? _currentUrl;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  /// ================= VIDEO LOGIC =================

  void setVideo(String? url) {
    if (url == null || url.isEmpty) return;
    if (_currentUrl == url) return;
    _currentUrl = url;
    _initVideo(url);
  }

  Future<void> _initVideo(String videoUrl) async {
    debugPrint("Intro video: ${introVideoUrl.value}");

    isInitialized.value = false;

    videoController?.dispose();
    chewieController?.dispose();

    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    await videoController!.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: false,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      allowMuting: true,
    );

    isInitialized.value = true;
  }

  /// ================= PROFILE API =================

  Future<void> loadProfile() async {
    debugPrint('Loading profile...');
    try {
      isLoading.value = true;

      final data = await _repository.getProfile();
      debugPrint('Profile API response: $data');

      if (data['profile'] == null) {
        throw Exception('Profile data missing');
      }

      final fullName = data['profile']['name'];

      userName.value = fullName;
      userEmail.value = data['email'] ?? '';
      userPhone.value = data['profile']['phone'];
      avatarUrl.value = data['profile']['avatar'];
      introVideoUrl.value = data['introduction'];

      /// INIT VIDEO JUST LIKE ONLINE CLASS
      setVideo(introVideoUrl.value);

      userHandle.value = generateHandle(fullName);
    } catch (e, s) {
      debugPrint('Error loading profile: $e');
      debugPrint('Stack trace: $s');
      Get.snackbar('Error', e.toString(), backgroundColor: AppColors.redColor);
    } finally {
      isLoading.value = false;
    }
  }

  String generateHandle(String name) {
    if (name.trim().isEmpty) return '';
    return '@${name.trim().split(' ').first.toLowerCase()}';
  }

  /// ================= LOGOUT =================

  Future<void> logout() async {
    try {
      await _repository.logout();
      Get.delete<ProfileController>(force: true);
      Get.delete<PersonalInfoController>(force: true);
      Get.delete<SignInController>(force: true);
      Get.offAll(() => SignInPage());
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString());
    }
  }

  @override
  void onClose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
