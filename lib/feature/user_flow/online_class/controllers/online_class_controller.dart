import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class OnlineClassController extends GetxController {
  static OnlineClassController get instance => Get.find();

  VideoPlayerController? videoController;
  ChewieController? chewieController;
  final isInitialized = false.obs;
  String? _currentUrl;

  void setVideo(String? url) {
    if (url == null || url.isEmpty) return;
    if (_currentUrl == url) return;
    _currentUrl = url;
    _initVideo(url);
  }

  Future<void> _initVideo(String videoUrl) async {
    isInitialized.value = false;

    videoController?.dispose();
    chewieController?.dispose();

    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    await videoController!.initialize();

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

  @override
  void onClose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
