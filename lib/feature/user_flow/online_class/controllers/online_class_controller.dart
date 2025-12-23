import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class OnlineClassController extends GetxController {
  static OnlineClassController get instance => Get.find();
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  final isInitialized = false.obs;
  VoidCallback? onVideoCompleted;
  String? _currentUrl;
  bool _hasCompleted = false;

  /// ================= SET VIDEO =================
  void setVideo(String? url, {VoidCallback? onCompleted}) {
    if (url == null || url.isEmpty) return;
    if (_currentUrl == url) return;
    _currentUrl = url;
    _hasCompleted = false;
    onVideoCompleted = onCompleted;
    _initVideo(url);
  }

  /// ================= INIT VIDEO =================
  Future<void> _initVideo(String videoUrl) async {
    isInitialized.value = false;
    videoController?.dispose();
    chewieController?.dispose();
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController!.initialize();
    /// ================= LISTEN FOR VIDEO END =================
    videoController!.addListener(() {
      final controller = videoController!;
      if (!_hasCompleted && controller.value.position >= controller.value.duration) {
        _hasCompleted = true;
        onVideoCompleted?.call();
      }
    });

    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      allowMuting: true,
    );
    isInitialized.value = true;
  }

  /// ================= CLEANUP =================
  @override
  void onClose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
