import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  var currentPage = 0.obs;
  late PageController pageController;
  Timer? _timer;

  final int totalPages = 4;
  bool _isUserInteracting = false;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    currentPage.value = 0;
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_isUserInteracting) return;

      int nextPage = currentPage.value + 1;
      if (nextPage >= totalPages) nextPage = 0;

      currentPage.value = nextPage;

      if (pageController.hasClients) {
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void onUserInteractionStart() {
    _isUserInteracting = true;
  }

  void onUserInteractionEnd() {
    _isUserInteracting = false;
  }

  void setPage(int index) {
    currentPage.value = index;
  }

  /// if navgiagte from any bottom nav page then slider restart
  void restartSlider() {
    _startAutoSlide();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
